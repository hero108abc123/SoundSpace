import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_from_unfollowing.dart';
import 'package:soundspace/features/home/domain/usecase/get_tracks_from_unfollowings.dart';
import 'package:soundspace/features/home/domain/usecase/get_unfollowed_artist.dart';
import 'package:soundspace/features/home/domain/usecase/load_track.dart';

import '../../domain/entitites/track.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadData _loadData;
  final GetPlaylistsFromUnfollowings _getPlaylistsFromUnfollowings;
  final GetUnfollowedArtists _getUnfollowedArtists;
  final GetTracksFromUnfollowings _getTracksFromUnfollowings;

  HomeBloc({
    required LoadData loadData,
    required GetPlaylistsFromUnfollowings getPlaylistsFromUnfollowings,
    required GetUnfollowedArtists getUnfollowedArtists,
    required GetTracksFromUnfollowings getTracksFromUnfollowings,
  })  : _loadData = loadData,
        _getPlaylistsFromUnfollowings = getPlaylistsFromUnfollowings,
        _getUnfollowedArtists = getUnfollowedArtists,
        _getTracksFromUnfollowings = getTracksFromUnfollowings,
        super(HomeInitial()) {
    on<HomeTrackLoadData>(_onHomeTrackLoadData);
    on<DiscoveryPlaylistLoadData>(_onDiscoveryPlaylistLoadData);
    on<DiscoveryArtistLoadData>(_onDiscoveryArtistLoadData);
    on<DiscoveryTrackLoadData>(_onDiscoveryTrackLoadData);
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

  Future<void> _onDiscoveryTrackLoadData(
    DiscoveryTrackLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _getTracksFromUnfollowings(NoParams());
    res.fold(
      (failure) => emit(TrackFailure(failure.message)),
      (tracks) => emit(TrackSuccess(tracks)),
    );
  }

  Future<void> _onDiscoveryPlaylistLoadData(
    DiscoveryPlaylistLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _getPlaylistsFromUnfollowings(NoParams());
    res.fold(
      (failure) => emit(PlaylistFailure(failure.message)),
      (playlists) => emit(PlaylistSuccess(playlists)),
    );
  }

  Future<void> _onDiscoveryArtistLoadData(
    DiscoveryArtistLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final res = await _getUnfollowedArtists(NoParams());
    res.fold(
      (failure) => emit(ArtistFailure(failure.message)),
      (artists) => emit(ArtistSuccess(artists)),
    );
  }
}
