// filepath: e:/STUDY/Do an/DNCNDPT/Nangcao/SoundSpace/lib/features/home/domain/usecase/get_playlists_by_userid.dart
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';

class GetPlaylistsByUserId
    implements UseCase<List<Playlist>?, GetPlaylistsByUserIdParams> {
  final DiscoveryRepository discoveryRepository;

  GetPlaylistsByUserId(this.discoveryRepository);

  @override
  Future<Either<Failure, List<Playlist>?>> call(
      GetPlaylistsByUserIdParams params) {
    return discoveryRepository.getPlaylistsByUserId(userId: params.userId);
  }
}

class GetPlaylistsByUserIdParams {
  final int userId;

  GetPlaylistsByUserIdParams({required this.userId});
}
