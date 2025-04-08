// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/discovery/discovery_bloc.dart';
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
  StreamController<List<Track>> trackStream = StreamController.broadcast();
  late StreamSubscription _trackSubscription;

  @override
  void initState() {
    super.initState();
    context.read<DiscoveryBloc>().add(DiscoveryTrackLoadData());
    context.read<DiscoveryBloc>().add(DiscoveryArtistLoadData());

    observeData();
    Future.delayed(Duration.zero, () {
      if (!trackStream.isClosed) {
        trackStream.add(tracks);
      }
    });
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
    if (state is DiscoveryTrackFailure) {
      showSnackBar(context, state.message);
    } else if (state is DiscoveryArtistFailure) {
      showSnackBar(context, state.message);
    } else if (state is DiscoveryArtistSuccess) {
      setState(() {
        users.clear();
        if (state.artists != null) {
          users.addAll(state.artists!);
        }
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
              if (state is DiscoveryTrackSuccess) {
                tracks.clear();
                tracks.addAll(state.tracks!.where(
                    (track) => !tracks.any((t) => t.trackId == track.trackId)));
                if (!trackStream.isClosed) {
                  trackStream.add(tracks);
                }
              }
              return Discovery(
                users: users,
                tracks: tracks,
                parent: this,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _trackSubscription.cancel();
    trackStream.close();
    super.dispose();
  }

  void observeData() {
    _trackSubscription = trackStream.stream.listen((trackList) {
      if (!mounted) return;
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
}

class Discovery extends StatelessWidget {
  final List<Artist>? users;
  final List<Track> tracks;
  final _DiscoveryScreenState parent;
  const Discovery({
    super.key,
    required this.users,
    required this.tracks,
    required this.parent,
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
            hintText: 'Search...',
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Made for you',
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
                    track: track,
                    onNavigate: (Track selectedTrack) {
                      parent.navigate(track);
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

  Widget _buildFollowerTop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top followers',
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
              children: users!.take(10).map((user) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Followerstop(
                    track: user,
                    onNavigate: (selectedTrack) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserArtist(
                            playlist: Playlist(
                              title: 'Default Playlist',
                              image: '',
                              trackCount: 0,
                              id: 0,
                              follower: 0,
                              createBy: '',
                            ),
                            track: selectedTrack,
                            onNavigate: (track) {},
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
