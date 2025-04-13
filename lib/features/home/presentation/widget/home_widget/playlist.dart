import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';

class TrackItem extends StatelessWidget {
  final Playlist playlist;
  final Function(Playlist) onNavigate;

  const TrackItem({
    super.key,
    required this.playlist,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              Image.network(
                playlist.image,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
              Positioned(
                right: 2,
                top: 2,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/icon/home/icon_heart.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              )
            ]),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          playlist.title,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
        Text(
          '${playlist.follower} ${languageProvider.translate('followers')}',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
