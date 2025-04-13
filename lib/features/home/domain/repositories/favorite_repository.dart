import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

abstract interface class FavoriteRepository {
  Future<Either<Failure, List<Track>?>> getFavoriteTracks();
  Future<Either<Failure, List<Playlist>?>> getFollowedPlaylists();
  Future<Either<Failure, List<Track>?>> getTracksFromPlaylist({
    required int playlistId,
  });
}
