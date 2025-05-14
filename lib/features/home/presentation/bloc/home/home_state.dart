part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class TrackSuccess extends HomeState {
  final List<Track>? tracks;
  const TrackSuccess(this.tracks);
}

final class TrackFailure extends HomeState {
  final String error;

  const TrackFailure(this.error);
}

final class PlaylistsSuccess extends HomeState {
  final List<Playlist>? playlists;
  const PlaylistsSuccess(this.playlists);
}

final class PlaylistsFailure extends HomeState {
  final String error;

  const PlaylistsFailure(this.error);
}

final class ArtistsSuccess extends HomeState {
  final List<Artist>? artists;
  const ArtistsSuccess(this.artists);
}

final class ArtistsFailure extends HomeState {
  final String error;

  const ArtistsFailure(this.error);
}

final class IsFavoriteSuccess extends HomeState {
  final bool isFavorite;
  const IsFavoriteSuccess(this.isFavorite);
}

final class IsFavoriteFailure extends HomeState {
  final String error;

  const IsFavoriteFailure(this.error);
}

final class LikeTrackSuccess extends HomeState {
  final String message;
  const LikeTrackSuccess(this.message);
}

final class LikeTrackFailure extends HomeState {
  final String error;

  const LikeTrackFailure(this.error);
}

final class UnlikeTrackSuccess extends HomeState {
  final String message;
  const UnlikeTrackSuccess(this.message);
}

final class UnlikeTrackFailure extends HomeState {
  final String error;

  const UnlikeTrackFailure(this.error);
}
