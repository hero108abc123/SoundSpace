part of 'discovery_bloc.dart';

abstract class DiscoveryState {}

class DiscoveryInitial extends DiscoveryState {}

class DiscoveryLoading extends DiscoveryState {}

class DiscoveryTrackSuccess extends DiscoveryState {
  final List<Track>? tracks;
  DiscoveryTrackSuccess(this.tracks);
}

class DiscoveryPlaylistSuccess extends DiscoveryState {
  final List<Playlist>? playlists;
  DiscoveryPlaylistSuccess(this.playlists);
}

class DiscoveryArtistSuccess extends DiscoveryState {
  final List<Artist>? artists;
  DiscoveryArtistSuccess(this.artists);
}

class DiscoveryTrackFailure extends DiscoveryState {
  final String message;
  DiscoveryTrackFailure(this.message);
}

class DiscoveryPlaylistFailure extends DiscoveryState {
  final String message;
  DiscoveryPlaylistFailure(this.message);
}

class DiscoveryArtistFailure extends DiscoveryState {
  final String message;
  DiscoveryArtistFailure(this.message);
}

class DiscoveryAddToPlaylistSuccess extends DiscoveryState {
  final String message;
  DiscoveryAddToPlaylistSuccess(this.message);
}

class DiscoveryAddToPlaylistFailure extends DiscoveryState {
  final String message;
  DiscoveryAddToPlaylistFailure(this.message);
}

class DiscoveryIsFollowingArtistSuccess extends DiscoveryState {
  final bool isFollowing;
  DiscoveryIsFollowingArtistSuccess(this.isFollowing);
}

class DiscoveryIsFollowingArtistFailure extends DiscoveryState {
  final String message;
  DiscoveryIsFollowingArtistFailure(this.message);
}
