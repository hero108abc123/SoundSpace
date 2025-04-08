import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:soundspace/features/home/presentation/widget/favorite_widget/music_card.dart';
import 'package:soundspace/features/home/presentation/widget/favorite_widget/playlist_card.dart';

class FavoriteScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const FavoriteScreen(),
      );

  const FavoriteScreen({super.key});

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
        child: const Favorite(),
      ),
    );
  }
}

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final List<Track> favoriteTracks = [];
  final List<Playlist> favoritePlaylists = [];

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(FavoriteTrackLoadData());
    context.read<FavoriteBloc>().add(FavoritePlaylistLoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteTrackFailure) {
          showSnackBar(context, state.message);
        } else if (state is FavoritePlaylistFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Loader();
        }
        if (state is FavoriteTrackSuccess) {
          favoriteTracks.clear();
          favoriteTracks.addAll(state.tracks as Iterable<Track>);
        }
        if (state is FavoritePlaylistSuccess) {
          favoritePlaylists.clear();
          favoritePlaylists.addAll(state.playlists as Iterable<Playlist>);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildFavoriteSong(context),
              const SizedBox(height: 10),
              _buildFavoritePlaylist(context),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFavoriteSong(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Favorite Songs',
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
        const SizedBox(height: 10),
        Column(
          children: favoriteTracks.take(5).map((track) {
            return MusicCard(
              image: track.image,
              title: track.title,
              artist: track.artist,
              favorite: 1,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFavoritePlaylist(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Favorite Playlists',
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
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: favoritePlaylists.take(5).map((playlist) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PlaylistCard(
                  image: playlist.image,
                  title: playlist.title,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
