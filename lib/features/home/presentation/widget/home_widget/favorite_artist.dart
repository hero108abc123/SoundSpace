import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteArtist extends StatelessWidget {
  final String image;
  final String artist;

  const FavoriteArtist({
    super.key,
    required this.image,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: 140,
              height: 198,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          artist,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
