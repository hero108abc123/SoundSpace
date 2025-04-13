// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/discovery/discovery_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/widget/discovery_widget/followers_top.dart';
import 'package:soundspace/features/home/presentation/widget/discovery_widget/song_new.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/user_artist.dart';

import '../../../../../config/theme/app_pallete.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final List<Track> tracks = [];
  final List<Artist> users = [];
  final List<Playlist> playlists = [];

  @override
  void initState() {
    super.initState();
    final bloc = context.read<DiscoveryBloc>();
    bloc.add(DiscoveryTrackLoadData());
    bloc.add(DiscoveryArtistLoadData());
    context.read<UserBloc>().add(GetMyPlaylistsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: MultiBlocListener(
          listeners: [
            BlocListener<DiscoveryBloc, DiscoveryState>(
              listener: (context, state) {
                if (state is DiscoveryTrackFailure ||
                    state is DiscoveryArtistFailure ||
                    state is DiscoveryPlaylistFailure) {
                  showSnackBar(context, (state as dynamic).message);
                } else if (state is DiscoveryTrackSuccess) {
                  setState(() {
                    final newTracks = state.tracks ?? [];
                    for (var track in newTracks) {
                      if (!tracks.any((t) => t.trackId == track.trackId)) {
                        tracks.add(track);
                      }
                    }
                  });
                } else if (state is DiscoveryArtistSuccess) {
                  setState(() {
                    users
                      ..clear()
                      ..addAll(state.artists ?? []);
                  });
                } else if (state is DiscoveryPlaylistSuccess) {
                  setState(() {
                    playlists
                      ..clear()
                      ..addAll(state.playlists ?? []);
                  });
                }
              },
            ),
          ],
          child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
            builder: (context, state) {
              if (state is DiscoveryLoading) {
                return const Loader();
              }
              return Discovery(
                users: users,
                tracks: tracks,
                playlists: playlists,
                onTrackSelected: navigate,
              );
            },
          ),
        ),
      ),
    );
  }

  void navigate(Track track) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => NowPlaying(
          tracks: tracks,
          playingTrack: track,
        ),
      ),
    );
  }
}

class Discovery extends StatelessWidget {
  final List<Artist> users;
  final List<Track> tracks;
  final List<Playlist> playlists;
  final void Function(Track) onTrackSelected;

  const Discovery({
    super.key,
    required this.users,
    required this.tracks,
    required this.playlists,
    required this.onTrackSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(context),
          const SizedBox(height: 16),
          _buildSongNews(context),
          const SizedBox(height: 16),
          _buildFollowerTop(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: languageProvider.translate('search'),
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/icon/home/icon_search.png',
                width: 23,
                height: 23,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          ),
        ),
      ),
    );
  }

  Widget _buildSongNews(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    if (tracks.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.translate('made_fu'),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tracks.take(100).map((track) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Songnew(
                    playlists: playlists,
                    track: track,
                    onNavigate: onTrackSelected,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowerTop(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    if (users.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.translate('top_follower'),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: users.take(10).map((user) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Followerstop(
                    artist: user,
                    onNavigate: (selectedArtist) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserArtist(
                            onNavigate: (artist) {},
                            artist: selectedArtist,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
