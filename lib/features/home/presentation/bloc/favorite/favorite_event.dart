part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class FavoriteTrackLoadData extends FavoriteEvent {}

class FavoritePlaylistLoadData extends FavoriteEvent {}
