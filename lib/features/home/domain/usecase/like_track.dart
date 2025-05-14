import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';

class LikeTrack implements UseCase<String, LikeTrackParams> {
  final HomeRepository homeRepository;

  LikeTrack(this.homeRepository);

  @override
  Future<Either<Failure, String>> call(LikeTrackParams params) async {
    return await homeRepository.likeTrack(trackId: params.trackId);
  }
}

class LikeTrackParams {
  final int trackId;

  LikeTrackParams({required this.trackId});
}
