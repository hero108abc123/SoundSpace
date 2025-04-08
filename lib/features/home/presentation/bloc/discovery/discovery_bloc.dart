import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_by_userid.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_from_unfollowing.dart';
import 'package:soundspace/features/home/domain/usecase/get_tracks_by_userid.dart';
import 'package:soundspace/features/home/domain/usecase/get_tracks_from_unfollowings.dart';
import 'package:soundspace/features/home/domain/usecase/get_unfollowed_artist.dart';
import '../../../domain/entitites/artist.dart';
import '../../../domain/entitites/playlist.dart';
import '../../../domain/entitites/track.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final GetPlaylistsFromUnfollowings _getPlaylistsFromUnfollowings;
  final GetUnfollowedArtists _getUnfollowedArtists;
  final GetTracksFromUnfollowings _getTracksFromUnfollowings;
  final GetPlaylistsByUserId _getPlaylistsByUserId;
  final GetTracksByUserId _getTracksByUserId;

  DiscoveryBloc({
    required GetPlaylistsFromUnfollowings getPlaylistsFromUnfollowings,
    required GetUnfollowedArtists getUnfollowedArtists,
    required GetTracksFromUnfollowings getTracksFromUnfollowings,
    required GetPlaylistsByUserId getPlaylistsByUserId,
    required GetTracksByUserId getTracksByUserId,
  })  : _getPlaylistsFromUnfollowings = getPlaylistsFromUnfollowings,
        _getUnfollowedArtists = getUnfollowedArtists,
        _getTracksFromUnfollowings = getTracksFromUnfollowings,
        _getPlaylistsByUserId = getPlaylistsByUserId,
        _getTracksByUserId = getTracksByUserId,
        super(DiscoveryInitial()) {
    on<DiscoveryPlaylistLoadData>(_onDiscoveryPlaylistLoadData);
    on<DiscoveryArtistLoadData>(_onDiscoveryArtistLoadData);
    on<DiscoveryTrackLoadData>(_onDiscoveryTrackLoadData);
    on<GetPlaylistsByUserIdRequested>(_onGetPlaylistsByUserId);
    on<GetTracksByUserIdRequested>(_onGetTracksByUserId);
  }

  Future<void> _onGetPlaylistsByUserId(
    GetPlaylistsByUserIdRequested event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    final res = await _getPlaylistsByUserId(
        GetPlaylistsByUserIdParams(userId: event.userId));
    res.fold(
      (failure) => emit(DiscoveryPlaylistFailure(failure.message)),
      (playlists) => emit(DiscoveryPlaylistSuccess(playlists)),
    );
  }

  Future<void> _onDiscoveryTrackLoadData(
    DiscoveryTrackLoadData event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    final res = await _getTracksFromUnfollowings(NoParams());
    res.fold(
      (failure) => emit(DiscoveryTrackFailure(failure.message)),
      (tracks) => emit(DiscoveryTrackSuccess(tracks)),
    );
  }

  Future<void> _onDiscoveryPlaylistLoadData(
    DiscoveryPlaylistLoadData event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    final res = await _getPlaylistsFromUnfollowings(NoParams());
    res.fold(
      (failure) => emit(DiscoveryPlaylistFailure(failure.message)),
      (playlists) => emit(DiscoveryPlaylistSuccess(playlists)),
    );
  }

  Future<void> _onDiscoveryArtistLoadData(
    DiscoveryArtistLoadData event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    final res = await _getUnfollowedArtists(NoParams());
    res.fold(
      (failure) => emit(DiscoveryArtistFailure(failure.message)),
      (artists) => emit(DiscoveryArtistSuccess(artists)),
    );
  }

  Future<void> _onGetTracksByUserId(
    GetTracksByUserIdRequested event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    final res =
        await _getTracksByUserId(GetTracksByUserIdParams(userId: event.userId));
    res.fold(
      (failure) => emit(DiscoveryTrackFailure(failure.message)),
      (tracks) => emit(DiscoveryTrackSuccess(tracks)),
    );
  }
}
