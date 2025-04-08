// filepath: e:/STUDY/Do an/DNCNDPT/Nangcao/SoundSpace/lib/features/home/domain/usecase/get_tracks_by_userid.dart
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';

class GetTracksByUserId
    implements UseCase<List<Track>?, GetTracksByUserIdParams> {
  final DiscoveryRepository discoveryRepository;

  GetTracksByUserId(this.discoveryRepository);

  @override
  Future<Either<Failure, List<Track>?>> call(GetTracksByUserIdParams params) {
    return discoveryRepository.getTracksByUserId(userId: params.userId);
  }
}

class GetTracksByUserIdParams {
  final int userId;

  GetTracksByUserIdParams({required this.userId});
}
