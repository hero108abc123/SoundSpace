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

final class PlaylistSuccess extends HomeState {
  final List<Playlist>? playlists;
  const PlaylistSuccess(this.playlists);
}

final class PlaylistFailure extends HomeState {
  final String error;

  const PlaylistFailure(this.error);
}

final class ArtistSuccess extends HomeState {
  final List<Artist>? artists;
  const ArtistSuccess(this.artists);
}

final class ArtistFailure extends HomeState {
  final String error;

  const ArtistFailure(this.error);
}
