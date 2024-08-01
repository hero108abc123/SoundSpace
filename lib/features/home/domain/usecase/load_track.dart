import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';

class LoadData implements UseCase<List<Track>?, NoParams> {
  final HomeRepository homeRepository;
  LoadData(this.homeRepository);

  @override
  Future<Either<Failure, List<Track>?>> call(NoParams params) async {
    return await homeRepository.loadData();
  }
}
