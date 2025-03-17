import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';

class Songlist extends StatelessWidget {
  final Track track;
  final Function(Track) onNavigate;
  final List<Track> tracks;

  const Songlist({
    super.key,
    required this.track,
    required this.onNavigate,
    required this.tracks,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.9;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NowPlaying(
                playingTrack: track,
                tracks: tracks,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Opacity(
                  opacity: 0.5,
                  child: Image.network(
                    track.image,
                    fit: BoxFit.cover,
                    width: width,
                    height: width,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 20,
                child: Row(
                  children: [
                    Image.network(
                      track.image,
                      fit: BoxFit.cover,
                      width: 75,
                      height: 75,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(track.title,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        Text(track.artist,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/icon/home/icon_add.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/icon/home/icon_play.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
