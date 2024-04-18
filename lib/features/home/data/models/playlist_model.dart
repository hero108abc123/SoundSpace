import 'package:soundspace/features/home/data/models/track_model.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';

class PlaylistModel extends Playlist {
  PlaylistModel({
    required super.title,
    required super.tracks,
    required super.imageUrl,
  });

  static List<PlaylistModel> playlists = [
    PlaylistModel(
      title: 'Hip-hop R&B Mix',
      tracks: TrackModel.tracks,
      imageUrl:
          'https://images.unsplash.com/photo-1576525865260-9f0e7cfb02b3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1364&q=80',
    ),
    PlaylistModel(
      title: 'Rock & Roll',
      tracks: TrackModel.tracks,
      imageUrl:
          'https://images.unsplash.com/photo-1629276301820-0f3eedc29fd0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2848&q=80',
    ),
    PlaylistModel(
      title: 'Techno',
      tracks: TrackModel.tracks,
      imageUrl:
          'https://images.unsplash.com/photo-1594623930572-300a3011d9ae?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
    ),
  ];
}
