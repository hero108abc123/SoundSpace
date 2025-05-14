import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';

class IsFollowingArtist implements UseCase<bool, IsFollowingArtistParams> {
  final DiscoveryRepository discoveryRepository;

  IsFollowingArtist(this.discoveryRepository);

  @override
  Future<Either<Failure, bool>> call(IsFollowingArtistParams params) async {
    return await discoveryRepository.isFollowingArtist(
      targetUserId: params.artistId,
    );
  }
}

class IsFollowingArtistParams {
  final int artistId;

  IsFollowingArtistParams({required this.artistId});
}
