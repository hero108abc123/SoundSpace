part of 'discovery_bloc.dart';

abstract class DiscoveryEvent {}

class DiscoveryTrackLoadData extends DiscoveryEvent {}

class DiscoveryPlaylistLoadData extends DiscoveryEvent {}

class DiscoveryArtistLoadData extends DiscoveryEvent {}

class GetTracksByUserIdRequested extends DiscoveryEvent {
  final int userId;

  GetTracksByUserIdRequested({required this.userId});
}

class GetPlaylistsByUserIdRequested extends DiscoveryEvent {
  final int userId;

  GetPlaylistsByUserIdRequested({required this.userId});
}
