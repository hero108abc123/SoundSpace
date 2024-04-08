import 'package:fpdart/fpdart.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/error/failure.dart';
import 'package:soundspace/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:soundspace/features/auth/domain/entities/user.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> emailCheck({
    required String email,
  }) {
    // TODO: implement emailCheck
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String displayName,
    required int age,
    required String? gender,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
        age: age,
        gender: gender,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
