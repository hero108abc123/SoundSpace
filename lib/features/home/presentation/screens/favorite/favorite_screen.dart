import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/widget/favorite_widget/music_card.dart';

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
  final List<Track> tracks = [];
  final List<Playlist> playlists = [];
  StreamController<List<Track>> trackStream = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(FavoriteTrackLoadData());
    context.read<FavoriteBloc>().add(FavoritePlaylistLoadData());
    observeData();
    Future.delayed(const Duration(milliseconds: 100), () {
      trackStream.add(tracks);
    });
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
          tracks.clear();
          tracks.addAll(state.tracks!.where(
              (track) => !tracks.any((t) => t.trackId == track.trackId)));
          trackStream.add(tracks);
        }
        if (state is FavoritePlaylistSuccess) {
          playlists.clear();
          playlists.addAll(state.playlists ?? []);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildFavoriteSong(context, this),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFavoriteSong(BuildContext context, parent) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageProvider.translate('favorite_song'),
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: tracks.map((track) {
            return MusicCard(
              track: track,
              onNavigate: (Track selectedTrack) {
                parent.navigate(track);
              },
              tracks: tracks,
              playlists: [],
            );
          }).toList(),
        ),
      ],
    );
  }
}
