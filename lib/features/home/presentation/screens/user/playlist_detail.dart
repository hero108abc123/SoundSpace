import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/songs_item.dart';

class PlaylistDetail extends StatefulWidget {
  final Playlist playlist;

  const PlaylistDetail({super.key, required this.playlist});

  @override
  State<PlaylistDetail> createState() => _PlaylistDetailState();
}

class _PlaylistDetailState extends State<PlaylistDetail> {
  final List<Track> tracks = [];
  StreamController<List<Track>> trackStream = StreamController.broadcast();

  @override
  void initState() {
    super.initState();

    context.read<FavoriteBloc>().add(
          FavoritePlaylistLoadTracks(
            playlistId: widget.playlist.id,
          ),
        );
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoritePlaylistTracksFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Loader();
        }
        if (state is FavoritePlaylistTracksSuccess) {
          tracks.clear();
          tracks.addAll(state.tracks!.where(
              (track) => !tracks.any((t) => t.trackId == track.trackId)));
          trackStream.add(tracks);
        }
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 10),
                    _buildPlaylistInfo(),
                    const SizedBox(height: 10),
                    _buildOperation(),
                    const SizedBox(height: 10),
                    _buildSongList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'assets/images/icon/playlist/icon Back.png',
              width: 26,
              height: 25.08,
            ),
          ),
          Center(
            child: Image.network(
              widget.playlist.image,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.playlist.title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${tracks.length} songs',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImageButton('assets/images/icon/playlist/icon download.png'),
            const SizedBox(width: 10),
            Row(
              children: [
                _buildImageButton(
                    'assets/images/icon/playlist/icon Shuffle.png'),
                const SizedBox(width: 10),
                _buildImageButton('assets/images/icon/playlist/icon Play.png'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _buildTextButton(Icons.add, 'Add'),
            const SizedBox(width: 10),
            _buildTextButton(Icons.sort, 'Sort'),
            const SizedBox(width: 10),
            _buildTextButton(Icons.edit, 'Edit'),
          ],
        ),
      ],
    );
  }

  Widget _buildTextButton(IconData icon, String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageButton(String imagePath) {
    return IconButton(
      icon: Image.asset(
        imagePath,
        width: 30,
        height: 30,
      ),
      onPressed: () {},
    );
  }

  Widget _buildSongList() {
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                return SongsItem(
                  track: tracks[index],
                  onNavigate: (track) {
                    navigate(track);
                  },
                );
              },
            ),
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/icon/playlist/icon _delete.png',
              width: 30,
              height: 30,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
