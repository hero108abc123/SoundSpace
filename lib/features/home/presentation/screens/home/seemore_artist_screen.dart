import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/user_artist.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/seemore_artist.dart';

class SeemoreArtistScreen extends StatefulWidget {
  const SeemoreArtistScreen({super.key});

  @override
  State<SeemoreArtistScreen> createState() => _SeemoreArtistScreenState();
}

class _SeemoreArtistScreenState extends State<SeemoreArtistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeArtistsLoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ArtistsFailure) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Loader();
        }

        if (state is ArtistsSuccess) {
          final artists = state.artists;

          if (artists!.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Favorite artists',
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
                  'No favorite artists found.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Favorite artists',
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
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  return SeemoreArtist(
                    artist: artists[index],
                    onNavigate: (selectedArtist) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserArtist(
                            onNavigate: (_) {},
                            artist: selectedArtist,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        }

        return const SizedBox.shrink(); // fallback UI nếu không khớp state
      },
    );
  }
}
