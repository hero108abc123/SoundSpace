import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class CurrentUser implements UseCase<Profile, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
