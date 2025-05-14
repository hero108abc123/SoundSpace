import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/add_to_playlist.dart';

class Songnew extends StatelessWidget {
  final Track track;
  final Function(Track) onNavigate;
  final List<Playlist> playlists;

  const Songnew(
      {super.key,
      required this.track,
      required this.onNavigate,
      required this.playlists});

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
                  left: 2,
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
                Positioned(
                  right: 1,
                  top: 1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToPlaylist(
                            track: track,
                          ),
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/icon/home/icon_add.png',
                      width: 20,
                      height: 20,
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
