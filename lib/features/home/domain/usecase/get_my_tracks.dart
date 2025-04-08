import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class GetMyTracks implements UseCase<List<Track>?, NoParams> {
  final UserRepository userRepository;
  GetMyTracks(this.userRepository);

  @override
  Future<Either<Failure, List<Track>?>> call(NoParams params) async {
    return await userRepository.getMyTracks();
  }
}
