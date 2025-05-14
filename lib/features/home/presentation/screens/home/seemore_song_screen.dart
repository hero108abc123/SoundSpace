import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/homepage_screen.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/seemore_song.dart';

class SeemoreSongScreen extends StatefulWidget {
  final Function(Track) onNavigate;
  final List<Track> tracks;
  const SeemoreSongScreen(
      {super.key, required this.onNavigate, required this.tracks});

  @override
  State<SeemoreSongScreen> createState() => _SeemoreSongScreenState();
}

class _SeemoreSongScreenState extends State<SeemoreSongScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeTrackLoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
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
          final tracks = state.tracks;

          if (tracks!.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Songs',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: const Center(
                child: Text(
                  'No songs found.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Songs',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
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
              child: ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  return SeemoreSong(
                    track: tracks[index],
                    onNavigate: (selectedArtist) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NowPlaying(
                                playingTrack: tracks[index], tracks: tracks)),
                      );
                    },
                  );
                },
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
