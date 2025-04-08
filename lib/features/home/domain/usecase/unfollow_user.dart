// filepath: e:/STUDY/Do an/DNCNDPT/Nangcao/SoundSpace/lib/features/home/domain/usecase/unfollow_user.dart
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class UnfollowUser implements UseCase<String, UnfollowUserParams> {
  final UserRepository userRepository;

  UnfollowUser(this.userRepository);

  @override
  Future<Either<Failure, String>> call(UnfollowUserParams params) async {
    return await userRepository.unfollowUser(userId: params.userId);
  }
}

class UnfollowUserParams {
  final int userId;

  UnfollowUserParams({required this.userId});
}
