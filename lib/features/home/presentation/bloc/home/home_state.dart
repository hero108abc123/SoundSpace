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
