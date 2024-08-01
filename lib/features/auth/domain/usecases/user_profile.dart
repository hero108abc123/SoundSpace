import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class UserProfile implements UseCase<String, UserProfileParams> {
  final AuthRepository authRepository;
  const UserProfile(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserProfileParams params) async {
    return await authRepository.createProfile(
      displayName: params.displaName,
      age: params.age,
      gender: params.gender,
    );
  }
}

class UserProfileParams {
  final String displaName;
  final int age;
  final String gender;

  UserProfileParams({
    required this.displaName,
    required this.age,
    required this.gender,
  });
}
