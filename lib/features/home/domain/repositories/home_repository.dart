import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';

import '../entitites/track.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<Track>?>> loadData();
  Future<Either<Failure, List<Track>?>> getTracksFromUnfollowings();
  Future<Either<Failure, List<Playlist>?>> getPlaylistsFromUnfollowings();
  Future<Either<Failure, List<Artist>?>> getUnfollowedArtists();
}
