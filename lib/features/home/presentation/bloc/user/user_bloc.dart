import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/usecase/add_track.dart';
import 'package:soundspace/features/home/domain/usecase/create_playlist.dart';
import 'package:soundspace/features/home/domain/usecase/follow_user.dart';
import 'package:soundspace/features/home/domain/usecase/get_followers.dart';
import 'package:soundspace/features/home/domain/usecase/logout.dart';
import 'package:soundspace/features/home/domain/usecase/unfollow_user.dart';
import 'package:soundspace/features/home/domain/usecase/update_user_profile.dart';
import 'package:soundspace/features/home/domain/usecase/get_my_playlists.dart';
import 'package:soundspace/features/home/domain/usecase/get_my_tracks.dart';
import 'package:soundspace/features/home/presentation/bloc/home/home_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Logout _logout;
  final UpdateUserProfile _updateUserProfile;
  final GetMyPlaylists _getMyPlaylists;
  final GetMyTracks _getMyTracks;
  final GetFollowers _getFollowers;
  final FollowUser _followUser;
  final UnfollowUser _unfollowUser;
  final CreatePlaylist _createPlaylist;
  final AddTrack _addTrack;

  UserBloc({
    required Logout logout,
    required UpdateUserProfile updateUserProfile,
    required GetMyPlaylists getMyPlaylists,
    required GetMyTracks getMyTracks,
    required GetFollowers getFollowers,
    required FollowUser followUser,
    required UnfollowUser unfollowUser,
    required CreatePlaylist createPlaylist,
    required AddTrack addTrack,
  })  : _logout = logout,
        _followUser = followUser,
        _unfollowUser = unfollowUser,
        _updateUserProfile = updateUserProfile,
        _getMyPlaylists = getMyPlaylists,
        _getMyTracks = getMyTracks,
        _getFollowers = getFollowers,
        _createPlaylist = createPlaylist,
        _addTrack = addTrack,
        super(UserInitial()) {
    on<UserLogoutRequested>(_onUserLogoutRequested);
    on<UserProfileUpdateRequested>(_onUserProfileUpdateRequested);
    on<GetMyPlaylistsRequested>(_onGetMyPlaylistsRequested);
    on<GetMyTracksRequested>(_onGetMyTracksRequested);
    on<GetFollowersRequested>(_onGetFollowersRequested);
    on<FollowUserRequested>(_onFollowUserRequested);
    on<UnfollowUserRequested>(_onUnfollowUserRequested);
    on<CreatePlaylistRequested>(_onCreatePlaylistRequested);
    on<AddTrackRequested>(_onAddTrackRequested);
  }

  Future<void> _onUserLogoutRequested(
    UserLogoutRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _logout(NoParams());
    result.fold(
      (failure) => emit(UserLogoutFailure(failure.message)),
      (response) {
        emit(UserLogoutSuccess(response));
        // Dispatch UserLoggedOut event to HomeBloc
        event.homeBloc.add(UserLoggedOut());
      },
    );
  }

  Future<void> _onUserProfileUpdateRequested(
    UserProfileUpdateRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _updateUserProfile(UpdateUserProfileParams(
      displayName: event.displayName,
      age: event.age,
      gender: event.gender,
      image: event.image,
    ));
    result.fold(
      (failure) => emit(UserProfileUpdateFailure(failure.message)),
      (response) => emit(UserProfileUpdateSuccess(response)),
    );
  }

  Future<void> _onGetMyPlaylistsRequested(
    GetMyPlaylistsRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _getMyPlaylists(NoParams());
    result.fold(
      (failure) => emit(UserPlaylistsFailure(failure.message)),
      (playlists) => emit(UserPlaylistsSuccess(playlists)),
    );
  }

  Future<void> _onGetMyTracksRequested(
    GetMyTracksRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _getMyTracks(NoParams());
    result.fold(
      (failure) => emit(UserTracksFailure(failure.message)),
      (tracks) => emit(UserTracksSuccess(tracks)),
    );
  }

  Future<void> _onGetFollowersRequested(
    GetFollowersRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _getFollowers(NoParams());
    result.fold(
      (failure) => emit(UserFollowersFailure(failure.message)),
      (followers) => emit(UserFollowersSuccess(followers)),
    );
  }

  Future<void> _onFollowUserRequested(
    FollowUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _followUser(FollowUserParams(userId: event.userId));
    result.fold(
      (failure) => emit(UserFollowFailure(failure.message)),
      (response) => emit(UserFollowSuccess(response)),
    );
  }

  Future<void> _onUnfollowUserRequested(
    UnfollowUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result =
        await _unfollowUser(UnfollowUserParams(userId: event.userId));
    result.fold(
      (failure) => emit(UserUnfollowFailure(failure.message)),
      (response) => emit(UserUnfollowSuccess(response)),
    );
  }

  Future<void> _onCreatePlaylistRequested(
    CreatePlaylistRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _createPlaylist(CreatePlaylistParams(
      title: event.title,
      trackId: event.trackId,
    ));
    result.fold(
      (failure) => emit(UserCreatePlaylistFailure(failure.message)),
      (response) => emit(UserCreatePlaylistSuccess(response)),
    );
  }

  Future<void> _onAddTrackRequested(
    AddTrackRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await _addTrack(AddTrackParams(
      title: event.title,
      image: event.image,
      source: event.source,
      album: event.album,
      lyric: event.lyric,
    ));
    result.fold(
      (failure) => emit(UserAddTrackFailure(failure.message)),
      (response) => emit(UserAddTrackSuccess(response)),
    );
  }
}
