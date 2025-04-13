import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/add_to_playlist.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';

class MusicCard extends StatelessWidget {
  final Track track;
  final Function(Track) onNavigate;
  final List<Track> tracks;
  final List<Playlist> playlists;

  const MusicCard(
      {super.key,
      required this.track,
      required this.onNavigate,
      required this.tracks,
      required this.playlists});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
          child: Row(
            children: [
              // Ảnh nhạc
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  track.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),

              // Thông tin bài hát
              Expanded(
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
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      track.artist,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Image.asset(
                    'assets/images/icon/home/red_heart.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 4),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToPlaylist(),
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/icon/home/icon_add.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
