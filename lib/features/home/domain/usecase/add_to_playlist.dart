import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';

class AddToPlaylist implements UseCase<String, AddToPlaylistParams> {
  final DiscoveryRepository discoveryRepository;

  AddToPlaylist(this.discoveryRepository);

  @override
  Future<Either<Failure, String>> call(AddToPlaylistParams params) async {
    return await discoveryRepository.addToPlaylist(
        playlistId: params.playlistId, trackId: params.trackId);
  }
}

class AddToPlaylistParams {
  final int trackId;
  final int playlistId;

  AddToPlaylistParams({
    required this.trackId,
    required this.playlistId,
  });
}
