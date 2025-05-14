import 'package:flutter/material.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

class SongsItem extends StatelessWidget {
  final Track track;
  final Function(Track) onNavigate;

  const SongsItem({
    super.key,
    required this.track,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onNavigate(track),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
        leading: SizedBox(
          width: 50.0,
          height: 50.0,
          child: ClipOval(
            child: Image.network(
              track.image,
              fit: BoxFit.cover,
            ),
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
      ),
    );
  }
}
