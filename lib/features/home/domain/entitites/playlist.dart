class Playlist {
  final int id;
  final String title;
  final String image;
  final int follower;
  final String createBy;
  final int trackCount;

  Playlist({
    required this.id,
    required this.follower,
    required this.image,
    required this.title,
    required this.createBy,
    required this.trackCount,
  });
}
