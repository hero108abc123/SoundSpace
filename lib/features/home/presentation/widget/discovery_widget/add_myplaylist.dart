import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';

class AddMyPlaylist extends StatefulWidget {
  final Playlist playlist;
  final VoidCallback onPressed;

  const AddMyPlaylist({
    Key? key,
    required this.playlist,
    required this.onPressed,
  }) : super(key: key);

  @override
  _AddMyPlaylistState createState() => _AddMyPlaylistState();
}

class _AddMyPlaylistState extends State<AddMyPlaylist> {
  bool isSelected = false;

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Image.network(
              widget.playlist.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.playlist.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${widget.playlist.trackCount} ${languageProvider.translate('song')}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            onPressed: _toggleSelection,
          ),
        ],
      ),
    );
  }
}
