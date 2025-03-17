import 'package:flutter/material.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

class SongsItem extends StatelessWidget {
  final Track track;

  const SongsItem({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
      leading: ClipOval(
        child: Image.asset(
          track.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        track.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        track.artist,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
      tileColor: Colors.transparent,
    );
  }
}
