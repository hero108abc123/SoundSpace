import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/auth/domain/entities/user.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class UserEmailCheck implements UseCase<User, UserEmailCheckParams> {
  final AuthRepository authRepository;
  const UserEmailCheck(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserEmailCheckParams params) {
    return authRepository.emailCheck(
      email: params.email,
    );
  }
}

class UserEmailCheckParams {
  final String email;

  UserEmailCheckParams({
    required this.email,
  });
}
