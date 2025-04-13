import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/usecase/get_favorite_tracks.dart';
import 'package:soundspace/features/home/domain/usecase/get_followed_playlist.dart';
import 'package:soundspace/features/home/domain/usecase/get_tracks_from_playlist.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteTracks _getFavoriteTracks;
  final GetFollowedPlaylist _getFollowedPlaylist;
  final GetTracksFromPlaylist _getTracksFromPlaylist;

  FavoriteBloc({
    required GetFavoriteTracks getFavoriteTracks,
    required GetFollowedPlaylist getFollowedPlaylist,
    required GetTracksFromPlaylist getTracksFromPlaylist,
  })  : _getFavoriteTracks = getFavoriteTracks,
        _getFollowedPlaylist = getFollowedPlaylist,
        _getTracksFromPlaylist = getTracksFromPlaylist,
        super(FavoriteInitial()) {
    on<FavoriteTrackLoadData>(_onFavoriteTrackLoadData);
    on<FavoritePlaylistLoadData>(_onFavoritePlaylistLoadData);
    on<FavoritePlaylistLoadTracks>(_onFavoritePlaylistLoadTracks);
  }

  Future<void> _onFavoritePlaylistLoadData(
    FavoritePlaylistLoadData event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    final res = await _getFollowedPlaylist(NoParams());
    res.fold(
      (failure) => emit(FavoritePlaylistFailure(failure.message)),
      (playlists) => emit(FavoritePlaylistSuccess(playlists)),
    );
  }

  Future<void> _onFavoriteTrackLoadData(
    FavoriteTrackLoadData event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    final res = await _getFavoriteTracks(NoParams());
    res.fold(
      (failure) => emit(FavoriteTrackFailure(failure.message)),
      (tracks) => emit(FavoriteTrackSuccess(tracks)),
    );
  }

  Future<void> _onFavoritePlaylistLoadTracks(
    FavoritePlaylistLoadTracks event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    final res = await _getTracksFromPlaylist(
      GetTracksFromPlaylistParams(playlistId: event.playlistId),
    );
    res.fold(
      (failure) => emit(FavoriteTrackFailure(failure.message)),
      (tracks) => emit(FavoriteTrackSuccess(tracks)),
    );
  }
}
