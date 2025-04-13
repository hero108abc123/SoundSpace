import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';

class FavoriteArtist extends StatelessWidget {
  final Artist artist;
  final Function(Artist) onNavigate;

  const FavoriteArtist({
    super.key,
    required this.onNavigate,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => onNavigate(artist),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              artist.image,
              fit: BoxFit.cover,
              width: 140,
              height: 198,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          artist.displayName,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
