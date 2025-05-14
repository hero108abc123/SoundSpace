import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';

import '../entitites/track.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<Track>?>> loadData();
  Future<Either<Failure, List<Playlist>?>>
      getPlaylistsFromFollowings(); // New method
  Future<Either<Failure, List<Artist>?>> getFollowedArtists();
// New method

  Future<Either<Failure, bool>> isFavorite({
    required int trackId,
  });

  Future<Either<Failure, String>> likeTrack({
    required int trackId,
  });
  Future<Either<Failure, String>> unlikeTrack({
    required int trackId,
  });
}
