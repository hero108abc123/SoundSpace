import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';

class GetUnfollowedArtists implements UseCase<List<Artist>?, NoParams> {
  final HomeRepository homeRepository;

  GetUnfollowedArtists(this.homeRepository);

  @override
  Future<Either<Failure, List<Artist>?>> call(NoParams params) async {
    return await homeRepository.getUnfollowedArtists();
  }
}
