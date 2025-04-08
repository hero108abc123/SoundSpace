part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeTrackLoadData extends HomeEvent {}

class HomePlaylistsLoadData extends HomeEvent {}

class HomeArtistsLoadData extends HomeEvent {}

final class UserLoggedOut extends HomeEvent {}
