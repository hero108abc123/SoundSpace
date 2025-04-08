part of 'user_bloc.dart';

abstract class UserEvent {}

final class UserLogoutRequested extends UserEvent {
  final HomeBloc homeBloc;

  UserLogoutRequested({required this.homeBloc});
}

final class UserProfileUpdateRequested extends UserEvent {
  final String displayName;
  final int age;
  final String gender;
  final String image;

  UserProfileUpdateRequested({
    required this.displayName,
    required this.age,
    required this.gender,
    required this.image,
  });
}

final class GetMyPlaylistsRequested extends UserEvent {}

final class GetMyTracksRequested extends UserEvent {}

final class GetFollowersRequested extends UserEvent {}

final class FollowUserRequested extends UserEvent {
  final int userId;

  FollowUserRequested({required this.userId});
}

final class UnfollowUserRequested extends UserEvent {
  final int userId;

  UnfollowUserRequested({required this.userId});
}

final class CreatePlaylistRequested extends UserEvent {
  final String title;
  final int trackId;

  CreatePlaylistRequested({
    required this.title,
    required this.trackId,
  });
}

final class AddTrackRequested extends UserEvent {
  final String title;
  final String image;
  final String source;
  final String album;
  final String lyric;

  AddTrackRequested({
    required this.title,
    required this.image,
    required this.source,
    required this.album,
    required this.lyric,
  });
}
