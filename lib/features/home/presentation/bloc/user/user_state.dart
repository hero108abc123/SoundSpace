part of 'user_bloc.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLogoutSuccess extends UserState {
  final String message;
  UserLogoutSuccess(this.message);
}

final class UserLogoutFailure extends UserState {
  final String message;
  UserLogoutFailure(this.message);
}

final class UserProfileUpdateSuccess extends UserState {
  final String message;
  UserProfileUpdateSuccess(this.message);
}

final class UserProfileUpdateFailure extends UserState {
  final String message;
  UserProfileUpdateFailure(this.message);
}

final class UserPlaylistsSuccess extends UserState {
  final List<Playlist>? playlists;
  UserPlaylistsSuccess(this.playlists);
}

final class UserPlaylistsFailure extends UserState {
  final String message;
  UserPlaylistsFailure(this.message);
}

final class UserTracksSuccess extends UserState {
  final List<Track>? tracks;
  UserTracksSuccess(this.tracks);
}

final class UserTracksFailure extends UserState {
  final String message;
  UserTracksFailure(this.message);
}

final class UserFollowersSuccess extends UserState {
  final List<Artist>? followers;
  UserFollowersSuccess(this.followers);
}

final class UserFollowersFailure extends UserState {
  final String message;
  UserFollowersFailure(this.message);
}

final class UserFollowSuccess extends UserState {
  final String message;
  UserFollowSuccess(this.message);
}

final class UserFollowFailure extends UserState {
  final String message;
  UserFollowFailure(this.message);
}

final class UserUnfollowSuccess extends UserState {
  final String message;
  UserUnfollowSuccess(this.message);
}

final class UserUnfollowFailure extends UserState {
  final String message;
  UserUnfollowFailure(this.message);
}

final class UserCreatePlaylistSuccess extends UserState {
  final String message;
  UserCreatePlaylistSuccess(this.message);
}

final class UserCreatePlaylistFailure extends UserState {
  final String message;
  UserCreatePlaylistFailure(this.message);
}

final class UserAddTrackSuccess extends UserState {
  final String message;
  UserAddTrackSuccess(this.message);
}

final class UserAddTrackFailure extends UserState {
  final String message;
  UserAddTrackFailure(this.message);
}
