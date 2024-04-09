import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/auth/domain/entities/user.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class Userlogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const Userlogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) {
    return authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
