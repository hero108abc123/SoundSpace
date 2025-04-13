import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/widget/discovery_widget/add_myplaylist.dart';

class AddToPlaylist extends StatefulWidget {
  const AddToPlaylist({
    super.key,
  });

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  final List<Playlist> playlists = [];

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetMyPlaylistsRequested());
  }

  void _addToPlaylist(Playlist selectedPlaylist) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to ${selectedPlaylist.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    String playlistName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final languageProvider = Provider.of<LanguageProvider>(context);
        return AlertDialog(
          title: Text(
            languageProvider.translate('give_playlist_name'),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                languageProvider.translate('cancel'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (playlistName.isNotEmpty && !_playlistExists(playlistName)) {
                  _createNewPlaylist(playlistName);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${languageProvider.translate('playlist')} $playlistName ${languageProvider.translate('already')}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text(
                languageProvider.translate('create'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _playlistExists(String name) {
    return playlists.any((playlist) => playlist.title == name);
  }

  void _createNewPlaylist(String name) {
    final newPlaylist = Playlist(
      title: name,
      image: 'assets/images/Goat.jpg',
      trackCount: 0,
      id: playlists.length + 1,
      follower: 0,
      createBy: 'You',
    );

    setState(() {
      playlists.add(newPlaylist);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playlist "$name" created!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageProvider.translate('add_to_playlist'),
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              _showCreatePlaylistDialog(context);
            },
            icon: Image.asset(
              'assets/images/icon/home/icon_add.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserPlaylistsFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Loader();
          }
          if (state is UserPlaylistsSuccess) {
            playlists.clear();
            playlists.addAll(state.playlists as Iterable<Playlist>);
          }
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
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return AddMyPlaylist(
                  playlist: playlists[index],
                  onPressed: () => _addToPlaylist(playlists[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
