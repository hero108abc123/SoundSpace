import 'package:flutter/material.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';

class SeemorePlaylist extends StatelessWidget {
  final Playlist playlist;
  final Function(Playlist) onNavigate;
  const SeemorePlaylist(
      {super.key, required this.playlist, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onNavigate(playlist),
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: Image.network(
                playlist.image,
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
                  playlist.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  playlist.createBy,
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
