import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';

class GetUnfollowedArtists implements UseCase<List<Artist>?, NoParams> {
  final DiscoveryRepository discoveryRepository;
  GetUnfollowedArtists(this.discoveryRepository);

  @override
  Future<Either<Failure, List<Artist>?>> call(NoParams params) async {
    return await discoveryRepository.getUnfollowedArtists();
  }
}
