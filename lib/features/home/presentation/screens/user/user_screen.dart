import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/screens/user/edit_profile_page.dart';
import 'package:soundspace/features/home/presentation/screens/user/followers_page.dart';
import 'package:soundspace/features/home/presentation/screens/user/following_page.dart';
import 'package:soundspace/features/home/presentation/screens/user/setting_screen.dart';
import 'package:soundspace/features/home/presentation/screens/user/upload_track_page.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/playlist_item.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/songs_item.dart';
import '../../../../../config/theme/app_pallete.dart';

class UserScreen extends StatefulWidget {
  final Profile user;
  const UserScreen({super.key, required this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? avatarUrl;
  final List<Track> tracks = [];
  final List<Playlist> playlists = [];
  StreamController<List<Track>> trackStream = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetMyTracksRequested());
    context.read<UserBloc>().add(GetMyPlaylistsRequested());

    avatarUrl = widget.user.image;
    observeData();

    Future.delayed(Duration.zero, () {
      if (!trackStream.isClosed) {
        trackStream.add(tracks);
      }
    });
  }

  @override
  void dispose() {
    trackStream.close();
    super.dispose();
  }

  void observeData() {
    trackStream.stream.listen((trackList) {
      setState(() {
        for (var track in trackList) {
          if (!tracks.any((t) => t.trackId == track.trackId)) {
            tracks.add(track);
          }
        }
      });
    });
  }

  void navigate(Track track) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return NowPlaying(
        tracks: tracks,
        playingTrack: track,
      );
    }));
  }

  void _updateAvatar(String newAvatarPath) {
    setState(() {
      avatarUrl = newAvatarPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
            AppPallete.gradient4,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserTracksFailure) {
            showSnackBar(context, state.message);
          } else if (state is UserPlaylistsFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Loader();
          }
          if (state is UserTracksSuccess) {
            tracks.clear();
            tracks.addAll(state.tracks!.where(
                (track) => !tracks.any((t) => t.trackId == track.trackId)));
            trackStream.add(tracks);
          }
          if (state is UserPlaylistsSuccess) {
            playlists.clear();
            playlists.addAll(state.playlists as Iterable<Playlist>);
          }
          return UserAccount(
            tracks: tracks,
            user: widget.user,
            playlists: playlists,
            avatarUrl: avatarUrl,
            onAvatarChanged: _updateAvatar,
            onNavigate: navigate,
          );
        },
      ),
    );
  }
}

class UserAccount extends StatelessWidget {
  final Profile user;
  final List<Track> tracks;
  final List<Playlist> playlists;
  final String? avatarUrl;
  final ValueChanged<String> onAvatarChanged;
  final Function(Track) onNavigate;

  const UserAccount({
    super.key,
    required this.tracks,
    required this.user,
    required this.playlists,
    required this.avatarUrl,
    required this.onAvatarChanged,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),
          _buildProfileInfo(context),
          const SizedBox(height: 10),
          _buildPlaylists(context),
          _more(),
          const SizedBox(height: 10),
          _buildMySongs(context),
          _more(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingTab()),
              );
            },
            icon: Image.asset(
              'assets/images/icon/user_setting/icon_setting.png',
              width: 26,
              height: 25.08,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                    ? NetworkImage(avatarUrl!)
                    : const AssetImage('assets/images/default_avatar.jpg')
                        as ImageProvider<Object>, // Default avatar
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                            user: user,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Edit',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 44, 44, 44)),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.displayName,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FollowersPage(),
                      ),
                    );
                  },
                  child: Text(
                    '${user.followersCount} followers',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text(
                  ' • ',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FollowingPage(),
                      ),
                    );
                  },
                  child: Text(
                    '${user.followingCount} following',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPlaylists(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Playlists',
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 2),
          Column(
            children: playlists
                .map((playlist) => Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: PlaylistItem(playlist: playlist)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMySongs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Songs',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadTrackPage()),
                  );
                },
                icon: Image.asset(
                  'assets/images/icon/home/icon_add.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Column(
            children: tracks
                .map((track) => Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: SongsItem(
                        track: track,
                        onNavigate: (selectedTrack) =>
                            onNavigate(selectedTrack),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _more() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          'More+',
          style: GoogleFonts.poppins(
              fontSize: 14, color: const Color.fromARGB(255, 196, 196, 196)),
        ),
      ),
    );
  }
}
