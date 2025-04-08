import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistCard extends StatelessWidget {
  final String image;
  final String title;

  const PlaylistCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: 135,
              height: 180,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
