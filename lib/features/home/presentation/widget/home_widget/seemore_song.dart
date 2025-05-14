import 'package:flutter/material.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

class SeemoreSong extends StatelessWidget {
  final Track track;
  final Function(Track) onNavigate;
  const SeemoreSong({super.key, required this.track, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onNavigate(track),
            child: ClipOval(
              child: Image.network(
                track.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  track.artist,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
