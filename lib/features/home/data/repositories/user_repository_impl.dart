// filepath: e:\STUDY\Do an\DNCNDPT\Nangcao\SoundSpace\lib\features\home\data\repositories\user_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/data/data_sources/user_remote_date_source.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final response = await _userRemoteDataSource.logout();
      if (response != "Logout failed") {
        return right(response);
      } else {
        return left(Failure("Logout failed"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateUserProfile({
    required String displayName,
    required int age,
    required String gender,
    required String image,
  }) async {
    try {
      final response = await _userRemoteDataSource.updateUserProfile(
        displayName: displayName,
        age: age,
        gender: gender,
        image: image,
      );
      if (response != "Profile update failed") {
        return right(response);
      } else {
        return left(Failure("Profile update failed"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Playlist>?>> getMyPlaylists() async {
    try {
      final playlists = await _userRemoteDataSource.getMyPlaylists();
      return right(playlists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Track>?>> getMyTracks() async {
    try {
      final tracks = await _userRemoteDataSource.getMyTracks();
      return right(tracks);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Artist>?>> getFollowers() async {
    try {
      final remoteArtists = await _userRemoteDataSource.getFollowers();
      return right(remoteArtists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> followUser({
    required int userId,
  }) async {
    try {
      final response = await _userRemoteDataSource.followUser(userId: userId);
      if (response != "Failed to follow user") {
        return right(response);
      } else {
        return left(Failure("Failed to follow user"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> unfollowUser({
    required int userId,
  }) async {
    try {
      final response = await _userRemoteDataSource.unfollowUser(userId: userId);
      if (response != "Failed to unfollow user") {
        return right(response);
      } else {
        return left(Failure("Failed to unfollow user"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createPlaylist({
    required String title,
    required int trackId,
  }) async {
    try {
      final response = await _userRemoteDataSource.createPlaylist(
        title: title,
        trackId: trackId,
      );
      if (response != "Failed to create playlist") {
        return right(response);
      } else {
        return left(Failure("Failed to create playlist"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addTrack({
    required String title,
    required String image,
    required String source,
    required String album,
    required String lyric,
  }) async {
    try {
      final response = await _userRemoteDataSource.addTrack(
        title: title,
        image: image,
        source: source,
        album: album,
        lyric: lyric,
      );
      if (response != "Failed to add track") {
        return right(response);
      } else {
        return left(Failure("Failed to add track"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
