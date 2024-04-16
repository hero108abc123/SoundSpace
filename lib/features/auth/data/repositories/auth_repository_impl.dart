import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/common/entities/user.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:soundspace/features/auth/data/models/email_model.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure("User not logged in!"));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, EmailModel>> emailValidation({
    required String email,
  }) async {
    try {
      final userEmail = await remoteDataSource.emailValidation(email: email);
      if (userEmail.email == "Email not found!") {
        return left(Failure("Email not found!"));
      }
      return right(userEmail);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.login(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String displayName,
    required int age,
    required String? gender,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
        age: age,
        gender: gender,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
