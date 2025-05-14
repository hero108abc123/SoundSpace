part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeTrackLoadData extends HomeEvent {}

class HomePlaylistsLoadData extends HomeEvent {}

class HomeArtistsLoadData extends HomeEvent {}

final class UserLoggedOut extends HomeEvent {}

final class IsFavoriteEvent extends HomeEvent {
  final int trackId;

  IsFavoriteEvent({required this.trackId});
}

final class LikeTrackEvent extends HomeEvent {
  final int trackId;

  LikeTrackEvent({required this.trackId});
}

final class UnlikeTrackEvent extends HomeEvent {
  final int trackId;

  UnlikeTrackEvent({required this.trackId});
}
