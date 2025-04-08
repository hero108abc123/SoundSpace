// filepath: e:/STUDY/Do an/DNCNDPT/Nangcao/SoundSpace/lib/features/home/domain/usecase/create_playlist.dart
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class CreatePlaylist implements UseCase<String, CreatePlaylistParams> {
  final UserRepository userRepository;

  CreatePlaylist(this.userRepository);

  @override
  Future<Either<Failure, String>> call(CreatePlaylistParams params) async {
    return await userRepository.createPlaylist(
      title: params.title,
      trackId: params.trackId,
    );
  }
}

class CreatePlaylistParams {
  final String title;
  final int trackId;

  CreatePlaylistParams({
    required this.title,
    required this.trackId,
  });
}
