import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';

class TrackItem extends StatelessWidget {
  final Playlist track;
  final Function(Playlist) onNavigate;

  const TrackItem({
    super.key,
    required this.track,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
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
                track.image,
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
          track.title,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
        Text(
          '${track.follower} followers',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
