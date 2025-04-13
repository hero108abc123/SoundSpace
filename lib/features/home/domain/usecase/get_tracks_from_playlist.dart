import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/repositories/favorite_repository.dart';

class GetTracksFromPlaylist
    implements UseCase<List<Track>?, GetTracksFromPlaylistParams> {
  final FavoriteRepository favoriteRepository;

  GetTracksFromPlaylist(this.favoriteRepository);

  @override
  Future<Either<Failure, List<Track>?>> call(
      GetTracksFromPlaylistParams params) async {
    return await favoriteRepository.getTracksFromPlaylist(
        playlistId: params.playlistId);
  }
}

class GetTracksFromPlaylistParams {
  final int playlistId;

  GetTracksFromPlaylistParams({
    required this.playlistId,
  });
}
