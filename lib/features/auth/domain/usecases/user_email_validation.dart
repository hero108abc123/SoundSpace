import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class UserEmailValidation
    implements UseCase<String, UserEmailValidationParams> {
  final AuthRepository authRepository;
  const UserEmailValidation(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserEmailValidationParams params) {
    return authRepository.emailValidation(
      email: params.email,
    );
  }
}

class UserEmailValidationParams {
  final String email;

  UserEmailValidationParams({
    required this.email,
  });
}
