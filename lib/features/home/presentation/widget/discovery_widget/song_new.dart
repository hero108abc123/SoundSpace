import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

class Songnew extends StatelessWidget {
  final Track track;
  final Function(Track) onNavigate;

  const Songnew({
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
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                track.image.isNotEmpty
                    ? Image.network(
                        track.image,
                        fit: BoxFit.cover,
                        width: 125,
                        height: 125,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/avatar.png',
                          width: 125,
                          height: 125,
                        ),
                      )
                    : Image.asset(
                        'assets/images/avatar.png',
                        width: 125,
                        height: 125,
                      ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/icon/home/icon_play.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 125, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                track.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, 
              ),
              Text(
                track.artist,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
