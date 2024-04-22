import 'package:soundspace/features/home/domain/entitites/track.dart';

class TrackModel extends Track {
  TrackModel({
    required super.title,
    required super.description,
    required super.url,
    required super.coverUrl,
  });

  static List<TrackModel> tracks = [
    TrackModel(
      title: 'Goat',
      description: 'Polyphia',
      url: 'assets/tracks/Goat.mp3',
      coverUrl: 'assets/images/Goat.jpg',
    ),
    TrackModel(
      title: 'Goose',
      description: 'Polyphia',
      url: 'assets/tracks/Goose.mp3',
      coverUrl: 'assets/images/Goose.jpg',
    ),
    TrackModel(
      title: 'Lychee',
      description: 'RJ Pasin',
      url: 'assets/tracks/Lychee.mp3',
      coverUrl: 'assets/images/Lychee.jpg',
    ),
    TrackModel(
      title: 'The Worst',
      description: 'Polyphia',
      url: 'assets/tracks/The Worst.mp3',
      coverUrl: 'assets/images/The Worst.jpg',
    ),
  ];
}
