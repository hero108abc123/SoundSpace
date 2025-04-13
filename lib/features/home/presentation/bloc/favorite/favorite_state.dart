part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteTrackSuccess extends FavoriteState {
  final List<Track>? tracks;
  FavoriteTrackSuccess(this.tracks);
}

class FavoritePlaylistSuccess extends FavoriteState {
  final List<Playlist>? playlists;
  FavoritePlaylistSuccess(this.playlists);
}

class FavoriteTrackFailure extends FavoriteState {
  final String message;
  FavoriteTrackFailure(this.message);
}

class FavoritePlaylistFailure extends FavoriteState {
  final String message;
  FavoritePlaylistFailure(this.message);
}

class FavoritePlaylistTracksSuccess extends FavoriteState {
  final List<Track>? tracks;
  FavoritePlaylistTracksSuccess(this.tracks);
}

class FavoritePlaylistTracksFailure extends FavoriteState {
  final String message;
  FavoritePlaylistTracksFailure(this.message);
}
