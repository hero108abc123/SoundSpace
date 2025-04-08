import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/data/data_sources/favorite_remote_data_source.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource _favoriteRemoteDataSource;

  FavoriteRepositoryImpl(this._favoriteRemoteDataSource);

  @override
  Future<Either<Failure, List<Track>?>> getFavoriteTracks() async {
    try {
      final remoteTracks = await _favoriteRemoteDataSource.getFavoriteTracks();
      return right(remoteTracks);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Playlist>?>> getFollowedPlaylists() async {
    try {
      final remotePlaylists =
          await _favoriteRemoteDataSource.getFollowedPlaylists();
      return right(remotePlaylists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
