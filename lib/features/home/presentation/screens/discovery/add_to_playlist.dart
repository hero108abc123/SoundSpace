import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/presentation/widget/discovery_widget/add_myplaylist.dart';

class AddToPlaylist extends StatefulWidget {
  final Playlist playlist;

  const AddToPlaylist({Key? key, required this.playlist}) : super(key: key);

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  late List<Playlist> playlists;

  @override
  void initState() {
    super.initState();
    playlists = _fetchPlaylists();
  }

  List<Playlist> _fetchPlaylists() {
    return [
      Playlist(
        title: 'Chill Vibes',
        image: 'assets/images/Billielish3.jpg',
        trackCount: 15,
        id: 1,
        follower: 250,
        createBy: 'User A',
      ),
      Playlist(
        title: 'Workout Energy',
        image: 'assets/images/Billielish3.jpg',
        trackCount: 20,
        id: 2,
        follower: 500,
        createBy: 'User B',
      ),
      Playlist(
        title: 'Relaxing Sounds',
        image: 'assets/images/Billielish3.jpg',
        trackCount: 12,
        id: 3,
        follower: 150,
        createBy: 'User C',
      ),
    ];
  }

  void _addToPlaylist(Playlist selectedPlaylist) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to ${selectedPlaylist.title}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add to my playlist',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
        child: ListView.builder(
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            return AddMyPlaylist(
              playlist: playlists[index],
              onPressed: () => _addToPlaylist(playlists[index]),
            );
          },
        ),
      ),
    );
  }
}
