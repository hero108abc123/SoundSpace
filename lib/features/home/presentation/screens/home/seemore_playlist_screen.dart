import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/playlist_card_home.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/seemore_playlist.dart';

class SeemorePlaylistScreen extends StatefulWidget {
  final Function(Playlist) onNavigate;
  final List<Playlist> playlist;
  final List<Track> tracks;
  const SeemorePlaylistScreen(
      {super.key,
      required this.playlist,
      required this.onNavigate,
      required this.tracks});

  @override
  State<SeemorePlaylistScreen> createState() => _SeemorePlaylistScreenState();
}

class _SeemorePlaylistScreenState extends State<SeemorePlaylistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomePlaylistsLoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is PlaylistsFailure) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Loader();
        }

        if (state is PlaylistsSuccess) {
          final playlists = state.playlists;

          if (playlists!.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Playlists',
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
                  'No playlist found.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Playlists',
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
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  return SeemorePlaylist(
                    playlist: playlists[index],
                    onNavigate: (selectedPlaylist) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlaylistCardHome(
                                  playlist: playlists[index],
                                )),
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
