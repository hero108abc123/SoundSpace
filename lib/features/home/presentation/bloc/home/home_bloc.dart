import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/usecase/get_followed_artists.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_from_followings.dart';
import 'package:soundspace/features/home/domain/usecase/is_favorite.dart';
import 'package:soundspace/features/home/domain/usecase/like_track.dart';
import 'package:soundspace/features/home/domain/usecase/load_track.dart';
import 'package:soundspace/features/home/domain/usecase/unlike_track.dart';

import '../../../domain/entitites/track.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadData _loadData;
  final GetPlaylistsFromFollowings _getPlaylistsFromFollowings;
  final GetFollowedArtists _getFollowedArtists;
  final IsFavorite _isFavorite;
  final LikeTrack _likeTrack;
  final UnlikeTrack _unlikeTrack;

  HomeBloc({
    required LoadData loadData,
    required GetPlaylistsFromFollowings getPlaylistsFromFollowings,
    required GetFollowedArtists getFollowedArtists,
    required IsFavorite isFavorite,
    required LikeTrack likeTrack,
    required UnlikeTrack unlikeTrack,
  })  : _loadData = loadData,
        _getPlaylistsFromFollowings = getPlaylistsFromFollowings,
        _getFollowedArtists = getFollowedArtists,
        _isFavorite = isFavorite,
        _likeTrack = likeTrack,
        _unlikeTrack = unlikeTrack,
        super(HomeInitial()) {
    on<HomeTrackLoadData>(_onHomeTrackLoadData);
    on<HomePlaylistsLoadData>(_onHomePlaylistsLoadData);
    on<HomeArtistsLoadData>(_onHomeArtistsLoadData);
    on<UserLoggedOut>(_onUserLoggedOut); // Handle logout
    on<IsFavoriteEvent>(_onIsFavoriteEvent);
    on<LikeTrackEvent>(_onLikeTrackEvent);
    on<UnlikeTrackEvent>(_onUnlikeTrackEvent);
  }

  Future<void> _onHomeTrackLoadData(
    HomeTrackLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _loadData(NoParams());
    res.fold(
      (failure) => emit(TrackFailure(failure.message)),
      (tracks) => emit(TrackSuccess(tracks)),
    );
  }

  Future<void> _onHomePlaylistsLoadData(
    HomePlaylistsLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _getPlaylistsFromFollowings(NoParams());
    res.fold(
      (failure) => emit(PlaylistsFailure(failure.message)),
      (playlists) => emit(PlaylistsSuccess(playlists)),
    );
  }

  Future<void> _onHomeArtistsLoadData(
    HomeArtistsLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _getFollowedArtists(NoParams());
    res.fold(
      (failure) => emit(ArtistsFailure(failure.message)),
      (artists) => emit(ArtistsSuccess(artists)),
    );
  }

  // Reset the state when the user logs out
  void _onUserLoggedOut(UserLoggedOut event, Emitter<HomeState> emit) {
    emit(HomeInitial());
  }

  void _onIsFavoriteEvent(
    IsFavoriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _isFavorite(IsFavoriteParams(trackId: event.trackId));
    res.fold(
      (failure) => emit(IsFavoriteFailure(failure.message)),
      (isFavorite) => emit(IsFavoriteSuccess(isFavorite)),
    );
  }

  void _onLikeTrackEvent(
    LikeTrackEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _likeTrack(LikeTrackParams(trackId: event.trackId));
    res.fold(
      (failure) => emit(LikeTrackFailure(failure.message)),
      (message) => emit(LikeTrackSuccess(message)),
    );
  }

  void _onUnlikeTrackEvent(
    UnlikeTrackEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _unlikeTrack(UnlikeTrackParams(trackId: event.trackId));
    res.fold(
      (failure) => emit(UnlikeTrackFailure(failure.message)),
      (message) => emit(UnlikeTrackSuccess(message)),
    );
  }
}
