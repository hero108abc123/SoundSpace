import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';

class Followerstop extends StatelessWidget {
  final Artist track;
  final Function(Artist) onNavigate;

  const Followerstop({
    super.key,
    required this.track,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onNavigate(track),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(children: [
              track.image.isNotEmpty
                  ? Image.network(
                      track.image,
                      fit: BoxFit.cover,
                      width: 240,
                      height: 260,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/avatar.png',
                          width: 240,
                          height: 260),
                    )
                  : Image.asset('assets/images/avatar.png',
                      width: 240, height: 260),
              Positioned(
                left: 20,
                bottom: 30,
                child: Column(
                  children: [
                    Text(
                      track.displayName,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      '${track.followersCount} followers',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
