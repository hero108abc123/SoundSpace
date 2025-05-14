import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<Either<Failure, List<Track>?>> loadData() async {
    try {
      final remoteTracks = await _homeRemoteDataSource.loadData();
      return right(remoteTracks);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Playlist>?>> getPlaylistsFromFollowings() async {
    try {
      final remotePlaylists =
          await _homeRemoteDataSource.getPlaylistsFromFollowings();
      return right(remotePlaylists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Artist>?>> getFollowedArtists() async {
    try {
      final remoteArtists = await _homeRemoteDataSource.getFollowedArtists();
      return right(remoteArtists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite({required int trackId}) async {
    try {
      final isFavorite =
          await _homeRemoteDataSource.isFavorite(trackId: trackId);
      return right(isFavorite);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> likeTrack({
    required int trackId,
  }) async {
    try {
      final response = await _homeRemoteDataSource.likeTrack(trackId: trackId);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> unlikeTrack({
    required int trackId,
  }) async {
    try {
      final response =
          await _homeRemoteDataSource.unlikeTrack(trackId: trackId);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
