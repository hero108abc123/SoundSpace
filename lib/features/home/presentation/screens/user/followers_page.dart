import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/user_artist.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/follow_widget.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  final List<Artist> dummyFollowers = [];
  final List<Track> tracks = [];
  final List<Playlist> playlists = [];

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetFollowersRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFollowersFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return const Loader();
        }
        if (state is UserFollowersSuccess) {
          dummyFollowers.clear();
          dummyFollowers.addAll(state.followers!);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Followers',
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
              itemCount: dummyFollowers.length,
              itemBuilder: (context, index) {
                return FollowWidget(
                  artist: dummyFollowers[index],
                  onNavigate: (selectedArtist) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserArtist(
                          onNavigate: (artist) {},
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
      },
    );
  }
}
