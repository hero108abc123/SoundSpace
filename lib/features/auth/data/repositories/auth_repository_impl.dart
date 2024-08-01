import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/core/common/entities/user.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Profile>> currentUser() async {
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
  Future<Either<Failure, String>> emailValidation({
    required String email,
  }) async {
    try {
      final userEmail = await remoteDataSource.emailValidation(email: email);
      if (userEmail == "Email not found!") {
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
  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final accountSuccess = await remoteDataSource.signUp(
        email: email,
        password: password,
      );
      if (accountSuccess != "Create account success") {
        return left(Failure("Something went wrong!"));
      }
      return right(accountSuccess);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createProfile({
    required String displayName,
    required int age,
    required String gender,
  }) async {
    try {
      final profileSuccess = await remoteDataSource.createProfile(
        displayName: displayName,
        age: age,
        gender: gender,
      );
      if (profileSuccess != "Create profile success") {
        return left(Failure("Something went wrong!"));
      }
      return right(profileSuccess);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
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
