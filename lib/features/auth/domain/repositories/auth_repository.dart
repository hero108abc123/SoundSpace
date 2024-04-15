import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/common/entities/user.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/auth/domain/entities/email.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String displayName,
    required int age,
    required String? gender,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Email>> emailValidation({
    required String email,
  });

  Future<Either<Failure, User>> currentUser();
}
