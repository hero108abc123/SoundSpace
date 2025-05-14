import 'package:soundspace/features/home/domain/entitites/track.dart';

class Playlist {
  final int id;
  final String title;
  final String image;
  final int follower;
  final String createBy;
  final int trackCount;
  final List<Track> tracks;

  Playlist({
    required this.id,
    required this.follower,
    required this.image,
    required this.title,
    required this.createBy,
    required this.trackCount,
    required this.tracks,
  });
}
