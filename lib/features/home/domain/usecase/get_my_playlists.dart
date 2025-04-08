import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class GetMyPlaylists implements UseCase<List<Playlist>?, NoParams> {
  final UserRepository userRepository;
  GetMyPlaylists(this.userRepository);

  @override
  Future<Either<Failure, List<Playlist>?>> call(NoParams params) async {
    return await userRepository.getMyPlaylists();
  }
}
