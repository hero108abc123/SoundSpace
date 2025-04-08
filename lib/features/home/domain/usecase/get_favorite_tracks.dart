import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/repositories/favorite_repository.dart';

class GetFavoriteTracks implements UseCase<List<Track>?, NoParams> {
  final FavoriteRepository favoriteRepository;
  GetFavoriteTracks(this.favoriteRepository);

  @override
  Future<Either<Failure, List<Track>?>> call(NoParams params) async {
    return await favoriteRepository.getFavoriteTracks();
  }
}
