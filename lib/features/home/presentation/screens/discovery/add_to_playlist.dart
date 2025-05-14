import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/widget/discovery_widget/add_myplaylist.dart';
import 'package:soundspace/features/home/presentation/bloc/discovery/discovery_bloc.dart';

class AddToPlaylist extends StatefulWidget {
  final Track track;

  const AddToPlaylist({
    super.key,
    required this.track,
  });

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  List<Playlist> playlists = [];
  late TextEditingController _playlistController;

  @override
  void initState() {
    super.initState();
    _playlistController = TextEditingController();

    Future.microtask(() {
      final userState = context.read<AuthBloc>().state;
      if (userState is ProfileSuccess) {
        context.read<DiscoveryBloc>().add(
              GetPlaylistsByUserIdRequested(userId: userState.profile.id),
            );
      }
    });
  }

  @override
  void dispose() {
    _playlistController.dispose();
    super.dispose();
  }

  void _addToPlaylist(Playlist selectedPlaylist) {
    context.read<DiscoveryBloc>().add(
          AddToPlaylistRequested(
            trackId: widget.track.trackId,
            playlistId: selectedPlaylist.id,
          ),
        );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    _playlistController.clear();
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            languageProvider.translate('give_playlist_name'),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            controller: _playlistController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                languageProvider.translate('cancel'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final playlistName = _playlistController.text.trim();
                if (playlistName.isNotEmpty && !_playlistExists(playlistName)) {
                  _createNewPlaylist(playlistName);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${languageProvider.translate('playlist')} $playlistName ${languageProvider.translate('already')}',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text(
                languageProvider.translate('create'),
                style: GoogleFonts.poppins(fontSize: 16),
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
    context.read<UserBloc>().add(
          CreatePlaylistRequested(
            title: name,
            trackId: widget.track.trackId,
          ),
        );
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
      body: BlocListener<DiscoveryBloc, DiscoveryState>(
        listener: (context, state) {
          if (state is DiscoveryPlaylistFailure) {
            showSnackBar(context, state.message);
          } else if (state is DiscoveryAddToPlaylistFailure) {
            showSnackBar(context, state.message);
          } else if (state is DiscoveryAddToPlaylistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added to Playlist Successfully!'),
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pop();
          } else if (state is DiscoveryPlaylistSuccess) {
            setState(() {
              playlists = List<Playlist>.from(state.playlists!);
            });
          }
        },
        child: Builder(
          builder: (context) {
            return playlists.isEmpty
                ? const Loader()
                : Container(
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
      ),
    );
  }
}
