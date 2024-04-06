import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
    required String displayName,
    required int age,
    required String? gender,
  });

  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> emailCheck({
    required String email,
  });
}
