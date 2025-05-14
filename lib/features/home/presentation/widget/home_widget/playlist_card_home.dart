import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/songs_item.dart';

class PlaylistCardHome extends StatefulWidget {
  final Playlist playlist;

  const PlaylistCardHome({super.key, required this.playlist});

  @override
  State<PlaylistCardHome> createState() => _PlaylistCardHomeState();
}

class _PlaylistCardHomeState extends State<PlaylistCardHome> {
  List<Track> tracks = [];

  @override
  void initState() {
    super.initState();

    context
        .read<FavoriteBloc>()
        .add(FavoritePlaylistLoadTracks(playlistId: widget.playlist.id));
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoritePlaylistTracksFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        Widget content;

        if (state is FavoriteLoading) {
          content = const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteTrackSuccess && state.tracks != null) {
          content = _buildContent(state.tracks!);
        } else {
          content = const Center(child: Text('No tracks found.'));
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
            child: content,
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
            '${widget.playlist.trackCount} songs',
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
        _buildTextButton(Icons.sort, 'Sort'),
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

  Widget _buildContent(List<Track> tracks) {
    return SingleChildScrollView(
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
            _buildSongList(tracks), // Hiển thị danh sách track
          ],
        ),
      ),
    );
  }

  Widget _buildSongList(List<Track> tracks) {
    return ListView.builder(
      itemCount: tracks.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return SongsItem(
          track: tracks[index],
          onNavigate: (track) {
            navigate(track);
          },
        );
      },
    );
  }
}
