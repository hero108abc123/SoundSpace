import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';

class UnlikeTrack implements UseCase<String, UnlikeTrackParams> {
  final HomeRepository homeRepository;

  UnlikeTrack(this.homeRepository);

  @override
  Future<Either<Failure, String>> call(UnlikeTrackParams params) async {
    return await homeRepository.unlikeTrack(trackId: params.trackId);
  }
}

class UnlikeTrackParams {
  final int trackId;

  UnlikeTrackParams({required this.trackId});
}
