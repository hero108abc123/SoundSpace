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
