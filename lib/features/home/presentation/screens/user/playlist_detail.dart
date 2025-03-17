import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import '../../widget/user_widget/songs_item.dart';

class PlaylistDetail extends StatelessWidget {
  final String playlistTitle;
  final String userName;
  final List<Track> tracks;

  const PlaylistDetail({
    super.key,
    required this.playlistTitle,
    required this.userName,
    required this.tracks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 10),
                _buildPlaylistInfo(),
                const SizedBox(height: 10),
                _buildOperation(),
                const SizedBox(height: 10),
                _buildSongList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'assets/images/icon/playlist/icon Back.png',
              width: 26,
              height: 25.08,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/The Worst.jpg',
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            playlistTitle,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${tracks.length} songs',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImageButton('assets/images/icon/playlist/icon download.png'),
            const SizedBox(width: 10),
            Row(
              children: [
                _buildImageButton(
                    'assets/images/icon/playlist/icon Shuffle.png'),
                const SizedBox(width: 10),
                _buildImageButton('assets/images/icon/playlist/icon Play.png'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _buildTextButton(Icons.add, 'Add'),
            const SizedBox(width: 10),
            _buildTextButton(Icons.sort, 'Sort'),
            const SizedBox(width: 10),
            _buildTextButton(Icons.edit, 'Edit'),
          ],
        ),
      ],
    );
  }

  Widget _buildTextButton(IconData icon, String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageButton(String imagePath) {
    return IconButton(
      icon: Image.asset(
        imagePath,
        width: 30,
        height: 30,
      ),
      onPressed: () {},
    );
  }

  Widget _buildSongList() {
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return SongsItem(
                  track: track,
                );
              },
            ),
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/icon/playlist/icon _delete.png',
              width: 30,
              height: 30,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
