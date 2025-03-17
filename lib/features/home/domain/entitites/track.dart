class Track {
  final int trackId;
  final String title;
  final String artist;
  final String image;
  final String source;
  final String album;
  final int favorite;

  Track({
    required this.trackId,
    required this.title,
    required this.artist,
    required this.image,
    required this.album,
    required this.source,
    required this.favorite,
  });
}
