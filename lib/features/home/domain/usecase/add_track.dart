// filepath: e:/STUDY/Do an/DNCNDPT/Nangcao/SoundSpace/lib/features/home/domain/usecase/add_track.dart
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';

class AddTrack implements UseCase<String, AddTrackParams> {
  final UserRepository userRepository;

  AddTrack(this.userRepository);

  @override
  Future<Either<Failure, String>> call(AddTrackParams params) async {
    return await userRepository.addTrack(
      title: params.title,
      image: params.image,
      source: params.source,
      album: params.album,
      lyric: params.lyric,
    );
  }
}

class AddTrackParams {
  final String title;
  final String image;
  final String source;
  final String album;
  final String lyric;

  AddTrackParams({
    required this.title,
    required this.image,
    required this.source,
    required this.album,
    required this.lyric,
  });
}
