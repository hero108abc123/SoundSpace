import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class GetFollowers implements UseCase<List<Artist>?, NoParams> {
  final UserRepository userRepository;
  GetFollowers(this.userRepository);

  @override
  Future<Either<Failure, List<Artist>?>> call(NoParams params) async {
    return await userRepository.getFollowers();
  }
}
