import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, String>> updateUserProfile({
    required String displayName,
    required int age,
    required String gender,
    required String image,
  });
  Future<Either<Failure, List<Playlist>?>> getMyPlaylists();
  Future<Either<Failure, List<Track>?>> getMyTracks();
  Future<Either<Failure, List<Artist>?>> getFollowers();
  Future<Either<Failure, String>> followUser({
    required int userId,
  });
  Future<Either<Failure, String>> unfollowUser({
    required int userId,
  });
  Future<Either<Failure, String>> createPlaylist({
    required String title,
    required int trackId,
  });
  Future<Either<Failure, String>> addTrack({
    required String title,
    required String image,
    required String source,
    required String album,
    required String lyric,
  });
}
