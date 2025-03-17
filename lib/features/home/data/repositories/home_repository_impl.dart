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
  Future<Either<Failure, List<Playlist>?>>
      getPlaylistsFromUnfollowings() async {
    try {
      final remotePlaylists =
          await _homeRemoteDataSource.getPlaylistsFromUnfollowings();
      return right(remotePlaylists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Artist>?>> getUnfollowedArtists() async {
    try {
      final remoteArtists = await _homeRemoteDataSource.getUnfollowedArtists();
      return right(remoteArtists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Track>?>> getTracksFromUnfollowings() async {
    try {
      final remoteTracks =
          await _homeRemoteDataSource.getTracksFromUnfollowings();
      return right(remoteTracks);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
