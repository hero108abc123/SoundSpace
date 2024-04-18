import 'package:soundspace/features/home/data/models/track_model.dart';

class Playlist {
  final String title;
  final List<TrackModel> tracks;
  final String imageUrl;

  Playlist({
    required this.title,
    required this.tracks,
    required this.imageUrl,
  });
}
