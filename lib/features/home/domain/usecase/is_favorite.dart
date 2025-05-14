import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';

class IsFavorite implements UseCase<bool, IsFavoriteParams> {
  final HomeRepository homeRepository;

  IsFavorite(this.homeRepository);

  @override
  Future<Either<Failure, bool>> call(IsFavoriteParams params) async {
    return await homeRepository.isFavorite(trackId: params.trackId);
  }
}

class IsFavoriteParams {
  final int trackId;

  IsFavoriteParams({required this.trackId});
}
