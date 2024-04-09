import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:soundspace/features/auth/domain/entities/user.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> emailCheck({
    required String email,
  }) async {
    return _getUser(
      () async => await remoteDataSource.emailCheck(
        email: email,
      ),
    );
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
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
