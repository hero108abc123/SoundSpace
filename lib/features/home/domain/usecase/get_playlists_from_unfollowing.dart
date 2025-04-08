import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';

class GetPlaylistsFromUnfollowings
    implements UseCase<List<Playlist>?, NoParams> {
  final DiscoveryRepository discoveryRepository;
  GetPlaylistsFromUnfollowings(this.discoveryRepository);

  @override
  Future<Either<Failure, List<Playlist>?>> call(NoParams params) async {
    return await discoveryRepository.getPlaylistsFromUnfollowings();
  }
}
