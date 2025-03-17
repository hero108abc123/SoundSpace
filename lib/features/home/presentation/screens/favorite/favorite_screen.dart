import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const FavoriteScreen(),
      );

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ví dụ về danh sách bài hát yêu thích
    final List<Song> songs = [
      Song('Cơn mưa băng giá', 'Bằng Kiều', 'assets/images/Lychee.jpg'),
      Song('Chuyện hẹn hò', 'Quang Lê', 'assets/images/Lychee.jpg'),
      Song('Forget', 'Pogo', 'assets/images/Lychee.jpg'),
      Song('Mắt kết nối', 'Dương Đình Trí', 'assets/images/Lychee.jpg'),
    ];

    // Ví dụ về danh sách playlist yêu thích
    final List<Playlist> playlists = [
      Playlist('Happy #1', 'assets/images/Lychee.jpg'),
      Playlist('Wall Board', 'assets/images/Lychee.jpg'),
      Playlist('Rock', 'assets/images/Lychee.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF1A1A2E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Songs',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: songs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return SongCard(song: song);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Playlists',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return PlaylistCard(playlist: playlist);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String imageUrl;

  Song(this.title, this.artist, this.imageUrl);
}

class SongCard extends StatelessWidget {
  final Song song;

  const SongCard({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF162447),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Image.asset(song.imageUrl,
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text(song.title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(song.artist, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.favorite, color: Colors.red),
      ),
    );
  }
}

class Playlist {
  final String title;
  final String imageUrl;

  Playlist(this.title, this.imageUrl);
}

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(playlist.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      width: 120,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black54,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              playlist.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
