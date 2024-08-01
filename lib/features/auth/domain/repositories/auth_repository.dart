import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/core/common/entities/user.dart';
import 'package:soundspace/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> emailValidation({
    required String email,
  });

  Future<Either<Failure, String>> createProfile({
    required String displayName,
    required int age,
    required String gender,
  });

  Future<Either<Failure, Profile>> currentUser();
}
