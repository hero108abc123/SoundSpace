// filepath: e:/STUDY/Do an/DNCNDPT/Nangcao/SoundSpace/lib/features/home/domain/usecase/unfollow_user.dart
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class FollowUser implements UseCase<String, FollowUserParams> {
  final UserRepository userRepository;

  FollowUser(this.userRepository);

  @override
  Future<Either<Failure, String>> call(FollowUserParams params) async {
    return await userRepository.followUser(userId: params.userId);
  }
}

class FollowUserParams {
  final int userId;

  FollowUserParams({required this.userId});
}
