import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/exceptions.dart';

import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _homeLocalDataSource;
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._homeLocalDataSource, this._homeRemoteDataSource);

  @override
  Future<Either<Failure, List<Track>?>> loadData() async {
    try {
      List<Track> tracks = [];
      await _homeRemoteDataSource.loadData().then((remoteTracks) {
        if (remoteTracks == null) {
          _homeLocalDataSource.loadData().then((localTracks) {
            if (localTracks != null) {
              tracks.addAll(localTracks);
            }
          });
        } else {
          tracks.addAll(remoteTracks);
        }
      });
      return right(tracks);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
