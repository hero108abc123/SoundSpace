// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/widget/discovery_widget/followers_top.dart';
import 'package:soundspace/features/home/presentation/widget/discovery_widget/song_new.dart';
import '../../../../../config/theme/app_pallete.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final List<Track> tracks = [];
  final List<Artist> users = [];
  StreamController<List<Track>> trackStream = StreamController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(DiscoveryTrackLoadData());
    context.read<HomeBloc>().add(DiscoveryArtistLoadData());

    observeData();
    Future.delayed(Duration.zero, () {
      trackStream.add(tracks);
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
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is TrackFailure) {
                  showSnackBar(context, state.error);
                } else if (state is ArtistFailure) {
                  showSnackBar(context, state.error);
                }
              },
            ),
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is ArtistSuccess) {
                  setState(() {
                    users.clear();
                    users.addAll(state.artists as Iterable<Artist>);
                  });
                }
              },
            ),
          ],
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Loader();
              }
              if (state is TrackSuccess) {
                final newTracks = state.tracks!
                    .where((track) =>
                        !tracks.any((t) => t.trackId == track.trackId))
                    .toList();
                if (newTracks.isNotEmpty) {
                  trackStream.add(newTracks);
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
              children: tracks.map((track) {
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
              children: users!.map((user) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Followerstop(
                    track: user,
                    onNavigate: (selectedTrack) {},
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
