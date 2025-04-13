import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';

class Followerstop extends StatelessWidget {
  final Artist artist;
  final Function(Artist) onNavigate;

  const Followerstop({
    super.key,
    required this.artist,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onNavigate(artist),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(children: [
              artist.image.isNotEmpty
                  ? Image.network(
                      artist.image,
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
                      artist.displayName,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      '${artist.followersCount} ${languageProvider.translate('followers')}',
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
