import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

abstract class DiscoveryRepository {
  Future<Either<Failure, List<Track>?>> getTracksFromUnfollowings();
  Future<Either<Failure, List<Playlist>?>> getPlaylistsFromUnfollowings();
  Future<Either<Failure, List<Artist>?>> getUnfollowedArtists();
  Future<Either<Failure, List<Playlist>?>> getPlaylistsByUserId({
    required int userId,
  });
  Future<Either<Failure, List<Track>?>> getTracksByUserId({
    required int userId,
  });
}
