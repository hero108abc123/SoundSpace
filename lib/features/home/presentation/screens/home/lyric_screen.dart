import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/mini_player.dart';
import '../../../domain/entitites/track.dart';
import '../../widget/home_widget/audio_player_manager.dart';

class LyricScreen extends StatelessWidget {
  const LyricScreen({
    super.key,
    required this.track,
    required this.audioPlayerManager,
  });

  final Track track;
  final AudioPlayerManager audioPlayerManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.gradient1,
        title: Text(
          track.title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/icon/playlist/icon Back.png',
            color: Colors.white,
            width: 24,
            height: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppPallete.gradient1,
                    AppPallete.gradient2,
                    AppPallete.gradient4,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        track.lyric,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: MiniPlayer(
              track: track,
              audioPlayerManager: audioPlayerManager,
            ),
          ),
        ],
      ),
    );
  }
}
