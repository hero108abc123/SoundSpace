import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';

import '../entitites/track.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<Track>?>> loadData();
}
