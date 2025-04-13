import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';

class FeaturedAlbumWidget extends StatefulWidget {
  @override
  _FeaturedAlbumWidgetState createState() => _FeaturedAlbumWidgetState();
}

class _FeaturedAlbumWidgetState extends State<FeaturedAlbumWidget> {
  final List<Map<String, String>> albums = [
    {
      'title': 'Happier Than Ever',
      'artist': 'Billie Eilish',
      'image': 'assets/featured_abum/billie-eilish-Home.png',
    },
    {
      'title': '7 rings',
      'artist': 'Ariana Grande',
      'image':
          'assets/featured_abum/83_extraordinary_wallpaper_inspo_ariana_grande-removebg-preview.png',
    },
    {
      'title': 'Drama',
      'artist': 'Vương Nhất Bác',
      'image': 'assets/featured_abum/download-removebg-preview.png',
    },
  ];

  Map<String, String>? selectedAlbum;

  @override
  void initState() {
    super.initState();
    _loadRandomAlbum();
  }

  Future<void> _loadRandomAlbum() async {
    final prefs = await SharedPreferences.getInstance();
    final randomIndex =
        prefs.getInt('randomAlbumIndex') ?? Random().nextInt(albums.length);

    await prefs.setInt('randomAlbumIndex', (randomIndex + 1) % albums.length);

    setState(() {
      selectedAlbum = albums[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    if (selectedAlbum == null) {
      // Có thể hiển thị widget loading hoặc SizedBox()
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(37, 168, 205, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageProvider.translate('new_album'),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  selectedAlbum!['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  selectedAlbum!['artist']!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Image.asset(
              selectedAlbum!['image']!,
              width: 310,
              height: 160,
            ),
          ),
        ],
      ),
    );
  }
}

    