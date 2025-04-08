import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class Logout implements UseCase<String, NoParams> {
  final UserRepository userRepository;

  Logout(this.userRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await userRepository.logout();
  }
}
