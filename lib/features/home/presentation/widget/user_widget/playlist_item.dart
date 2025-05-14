import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/screens/user/playlist_detail.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;
  final List<Track> tracks;

  const PlaylistItem({super.key, required this.playlist, required this.tracks});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetail(
              playlist: playlist,
            ),
          ),
        );
      },
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
        leading: Image.network(playlist.image, width: 60, height: 60),
        title: Text(
          playlist.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${playlist.follower} ${languageProvider.translate('followers')}',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        tileColor: Colors.transparent,
      ),
    );
  }
}
