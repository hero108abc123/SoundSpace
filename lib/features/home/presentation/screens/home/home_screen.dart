// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/favorite_artist.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/navbar.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/playlist.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/song_list.dart';

class HomeScreen extends StatefulWidget {
  final Profile user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navbar(
        user: widget.user,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final List<Track> tracks = [];
  StreamController<List<Track>> trackStream = StreamController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeTrackLoadData());
    observeData();
    Future.delayed(Duration.zero, () {
      trackStream.add(tracks);
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
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is TrackFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Loader();
          }
          if (state is TrackSuccess) {
            final newTracks = state.tracks!
                .where(
                    (track) => !tracks.any((t) => t.trackId == track.trackId))
                .toList();
            if (newTracks.isNotEmpty) {
              trackStream.add(newTracks);
            }

            return HomeContent(
              tracks: tracks,
              parent: this,
            );
          }
          return const SizedBox();
        },
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

class HomeContent extends StatelessWidget {
  final List<Track> tracks;
  final _HomeTabPageState parent;

  const HomeContent({super.key, required this.parent, required this.tracks});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildFavoriteArtistCards(),
          _buildPlaylistSection(parent),
          _buildSong(parent)
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'SoundScape',
            style: TextStyle(
              fontFamily: 'Orbitron',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 168, 205, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Album',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Happier Than',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Ever',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Billie Eilish',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Image.asset(
                  'assets/images/billie-eilish-Home.png',
                  width: 316,
                  height: 184,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteArtistCards() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Favorite Artists',
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
                  child: FavoriteArtist(
                    image: track.image,
                    artist: track.artist,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistSection(_HomeTabPageState parent) {
    final List<Playlist> playlists = [
      Playlist(
        id: 1,
        title: 'Chill Vibes',
        image: 'assets/images/Billielish3.jpg',
        follower: 1200,
        createBy: 'Nguyenbeo',
        trackCount: 10,
      ),
      Playlist(
        id: 2,
        title: 'Workout Mix',
        image: 'assets/images/Lychee.jpg',
        follower: 800,
        createBy: 'Nguyetbeo',
        trackCount: 10,
      ),
      Playlist(
        id: 3,
        title: 'Relaxing Beats',
        image: 'assets/images/Billielish3.jpg',
        follower: 500,
        createBy: 'Nguyetbeo',
        trackCount: 10,
      ),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Playlist',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'See More',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: playlists.map((playlist) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: TrackItem(
                  track: playlist,
                  onNavigate: (Playlist playlist) {
                    parent.navigate(playlist as Track);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSong(_HomeTabPageState parent) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Song',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'See More',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: tracks.map((track) {
              return Songlist(
                track: track,
                onNavigate: (Track selectedTrack) {
                  parent.navigate(track);
                },
                tracks: const [],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
