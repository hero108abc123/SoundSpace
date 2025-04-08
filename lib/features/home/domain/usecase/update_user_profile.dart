import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class UpdateUserProfile implements UseCase<String, UpdateUserProfileParams> {
  final UserRepository userRepository;
  UpdateUserProfile(this.userRepository);

  @override
  Future<Either<Failure, String>> call(UpdateUserProfileParams params) async {
    return await userRepository.updateUserProfile(
      displayName: params.displayName,
      age: params.age,
      gender: params.gender,
      image: params.image,
    );
  }
}

class UpdateUserProfileParams {
  final String displayName;
  final int age;
  final String gender;
  final String image;

  UpdateUserProfileParams({
    required this.displayName,
    required this.age,
    required this.gender,
    required this.image,
  });
}
