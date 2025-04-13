part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class FavoriteTrackLoadData extends FavoriteEvent {}

class FavoritePlaylistLoadData extends FavoriteEvent {}

class FavoritePlaylistLoadTracks extends FavoriteEvent {
  final int playlistId;

  FavoritePlaylistLoadTracks({
    required this.playlistId,
  });
}
