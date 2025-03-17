import 'package:flutter/material.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/screens/user/playlist_detail.dart';

class PlaylistItem extends StatelessWidget {
  final String title;
  final int followers;
  final String imageUrl;
  final List<Track> tracks;

  const PlaylistItem({
    super.key,
    required this.title,
    required this.followers,
    required this.imageUrl,
    required this.tracks,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetail(
              playlistTitle: title,
              userName: 'Music User',
              tracks: tracks,
            ),
          ),
        );
      },
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
        leading: Image.asset(imageUrl, width: 60, height: 60),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '$followers followers',
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
