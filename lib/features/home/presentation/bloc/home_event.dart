part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeTrackLoadData extends HomeEvent {}

final class DiscoveryTrackLoadData extends HomeEvent {}

final class DiscoveryPlaylistLoadData extends HomeEvent {}

final class DiscoveryArtistLoadData extends HomeEvent {}
