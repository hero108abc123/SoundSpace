import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/repositories/favorite_repository.dart';

class GetFollowedPlaylist implements UseCase<List<Playlist>?, NoParams> {
  final FavoriteRepository favoriteRepository;
  GetFollowedPlaylist(this.favoriteRepository);

  @override
  Future<Either<Failure, List<Playlist>?>> call(NoParams params) async {
    return await favoriteRepository.getFollowedPlaylists();
  }
}
