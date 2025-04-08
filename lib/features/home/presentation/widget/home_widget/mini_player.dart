import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import '../../../domain/entitites/track.dart';
import '../../widget/home_widget/audio_player_manager.dart';

class MiniPlayer extends StatelessWidget {
  final Track track;
  final AudioPlayerManager audioPlayerManager;

  const MiniPlayer({
    super.key,
    required this.track,
    required this.audioPlayerManager,
  });

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: AppPallete.gradient4,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  track.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/Goat.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 100, 100, 100),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      track.artist,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 100, 100, 100),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<PlayerState>(
                stream: audioPlayerManager.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final playing = playerState?.playing ?? false;

                  return IconButton(
                    onPressed: playing
                        ? audioPlayerManager.player.pause
                        : audioPlayerManager.player.play,
                    icon: Icon(
                      playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 36,
                    ),
                  );
                },
              ),
            ],
          ),
          StreamBuilder<DurationState>(
            stream: audioPlayerManager.durationState,
            builder: (context, snapshot) {
              final durationState = snapshot.data;
              final progress = durationState?.progress ?? Duration.zero;
              final total = durationState?.total ?? Duration.zero;

              return Column(
                children: [
                  Slider(
                    min: 0,
                    max: total.inSeconds.toDouble(),
                    value: progress.inSeconds.toDouble(),
                    onChanged: (value) {
                      audioPlayerManager.player
                          .seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(progress),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          formatDuration(total),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
