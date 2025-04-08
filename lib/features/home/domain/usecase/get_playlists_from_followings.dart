import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';

class GetPlaylistsFromFollowings implements UseCase<List<Playlist>?, NoParams> {
  final HomeRepository homeRepository;
  GetPlaylistsFromFollowings(this.homeRepository);

  @override
  Future<Either<Failure, List<Playlist>?>> call(NoParams params) async {
    return await homeRepository.getPlaylistsFromFollowings();
  }
}
