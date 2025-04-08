import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  final String image;
  final String title;
  final String artist;
  final int favorite;

  const MusicCard({
    super.key,
    required this.image,
    required this.title,
    required this.artist,
    required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        children: [
          // Ảnh nhạc
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          // Thông tin bài hát
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  artist,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const Row(
            children: [
              Icon(Icons.favorite,
                  color: Color.fromARGB(255, 182, 35, 15), size: 20),
              SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }
}
