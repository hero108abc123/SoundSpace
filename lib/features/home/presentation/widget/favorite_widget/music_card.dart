import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';

class MusicCard extends StatelessWidget {
  final String title;
  final String artist;
  final VoidCallback onTap;

  const MusicCard({
    super.key,
    required this.title,
    required this.artist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: AppPallete.whiteColor),
        ),
        subtitle: Text(
          artist,
          style: const TextStyle(color: AppPallete.whiteColor),
        ),
        onTap: onTap,
        tileColor: AppPallete.gradient3, // Màu nền cho Card
      ),
    );
  }
}
