import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/screens/user/edit_profile_page.dart';
import 'package:soundspace/features/home/presentation/screens/user/followers_page.dart';
import 'package:soundspace/features/home/presentation/screens/user/following_page.dart';
import 'package:soundspace/features/home/presentation/screens/user/setting_screen.dart';
import 'package:soundspace/features/home/presentation/screens/user/upload_track_page.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/playlist_item.dart';
import '../../../../../config/theme/app_pallete.dart';

class UserScreen extends StatefulWidget {
  final List<Track> tracks;
  final Profile user;

  const UserScreen({super.key, required this.tracks, required this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    avatarUrl = widget.user.image;
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
      child: UserAccount(
        tracks: widget.tracks,
        user: widget.user,
        avatarUrl: avatarUrl,
        onAvatarChanged: _updateAvatar,
      ),
    );
  }
}

class UserAccount extends StatelessWidget {
  final Profile user;
  final List<Track> tracks;
  final String? avatarUrl;
  final ValueChanged<String> onAvatarChanged;

  const UserAccount({
    super.key,
    required this.tracks,
    required this.user,
    required this.avatarUrl,
    required this.onAvatarChanged,
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
                        builder: (context) => FollowersPage(),
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
                        builder: (context) => FollowingPage(),
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Playlists',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    _showCreatePlaylistDialog(context);
                  },
                  icon: Image.asset(
                    'assets/images/icon/home/icon_add.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Example playlist with song list
            PlaylistItem(
              title: '★ . .',
              followers: 8,
              imageUrl: 'assets/images/Lychee.jpg',
              tracks: [
                Track(
                    title: 'Track 1',
                    artist: 'Artist 1',
                    trackId: 1,
                    image: 'assets/images/Lychee.jpg',
                    album: '1',
                    source: '11',
                    favorite: 0,
                    lyric: 'Lyric 1'),
                Track(
                    title: 'Track 2',
                    artist: 'Artist 2',
                    trackId: 2,
                    image: 'assets/images/Lychee.jpg',
                    album: '1',
                    source: '11',
                    favorite: 0,
                    lyric: 'Lyric 2'),
              ],
            ),
            // Add more PlaylistItem if needed
          ],
        ),
      ),
    );
  }

  Widget _buildMySongs(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                      color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadTrackPage()),
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
          ],
        ),
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

  void _showCreatePlaylistDialog(BuildContext context) {
    String playlistName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Give your playlist a name',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: const InputDecoration(
              hintText: 'Playlist Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (playlistName.isNotEmpty) {
                  if (kDebugMode) {
                    print('Playlist Created: $playlistName');
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Create',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
