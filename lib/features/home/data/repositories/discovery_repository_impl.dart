import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/data/data_sources/discovery_remote_data_source.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import '../../domain/repositories/discovery_repository.dart';

class DiscoveryRepositoryImpl implements DiscoveryRepository {
  final DiscoveryRemoteDataSource _discoveryRemoteDataSource;

  DiscoveryRepositoryImpl(this._discoveryRemoteDataSource);

  @override
  Future<Either<Failure, List<Track>?>> getTracksFromUnfollowings() async {
    try {
      final remoteTracks =
          await _discoveryRemoteDataSource.getTracksFromUnfollowings();
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
          await _discoveryRemoteDataSource.getPlaylistsFromUnfollowings();
      return right(remotePlaylists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Artist>?>> getUnfollowedArtists() async {
    try {
      final remoteArtists =
          await _discoveryRemoteDataSource.getUnfollowedArtists();
      return right(remoteArtists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Playlist>?>> getPlaylistsByUserId({
    required int userId,
  }) async {
    try {
      final remotePlaylists =
          await _discoveryRemoteDataSource.getPlaylistsByUserId(userId: userId);
      return right(remotePlaylists);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Track>?>> getTracksByUserId({
    required int userId,
  }) async {
    try {
      final remoteTracks =
          await _discoveryRemoteDataSource.getTracksByUserId(userId: userId);
      return right(remoteTracks);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
