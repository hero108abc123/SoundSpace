import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/auth/domain/entities/user.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
      email: params.email,
      password: params.password,
      displayName: params.displayName,
      age: params.age,
      gender: params.gender,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String displayName;
  final int age;
  final String? gender;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.displayName,
    required this.age,
    required this.gender,
  });
}
