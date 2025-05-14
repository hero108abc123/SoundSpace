import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';

class SeemoreArtist extends StatelessWidget {
  final Artist artist;
  final Function(Artist) onNavigate;
  const SeemoreArtist(
      {super.key, required this.artist, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onNavigate(artist),
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: Image.network(
                artist.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artist.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${artist.followersCount} ${languageProvider.translate('followers')} • ${artist.followingCount} ${languageProvider.translate('following')}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
