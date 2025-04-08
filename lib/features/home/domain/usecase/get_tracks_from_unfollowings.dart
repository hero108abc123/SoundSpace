import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';

class GetTracksFromUnfollowings implements UseCase<List<Track>?, NoParams> {
  final DiscoveryRepository discoveryRepository;
  GetTracksFromUnfollowings(this.discoveryRepository);

  @override
  Future<Either<Failure, List<Track>?>> call(NoParams params) async {
    return await discoveryRepository.getTracksFromUnfollowings();
  }
}
