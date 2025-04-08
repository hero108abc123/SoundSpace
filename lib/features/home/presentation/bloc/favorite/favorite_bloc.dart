import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/usecase/get_favorite_tracks.dart';
import 'package:soundspace/features/home/domain/usecase/get_followed_playlist.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteTracks _getFavoriteTracks;
  final GetFollowedPlaylist _getFollowedPlaylist;

  FavoriteBloc({
    required GetFavoriteTracks getFavoriteTracks,
    required GetFollowedPlaylist getFollowedPlaylist,
  })  : _getFavoriteTracks = getFavoriteTracks,
        _getFollowedPlaylist = getFollowedPlaylist,
        super(FavoriteInitial()) {
    on<FavoriteTrackLoadData>(_onFavoriteTrackLoadData);
    on<FavoritePlaylistLoadData>(_onFavoritePlaylistLoadData);
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
}
