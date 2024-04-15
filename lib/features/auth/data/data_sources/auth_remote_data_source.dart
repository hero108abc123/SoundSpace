import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/auth/data/models/email_model.dart';
import 'package:soundspace/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String displayName,
    required int age,
    required String? gender,
  });
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<EmailModel> emailValidation({
    required String email,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;
  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserModel?> getCurrentUserData() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<EmailModel> emailValidation({
    required String email,
  }) async {
    try {
      final response = await _dioClient.post(
        "${Endpoints.auth}/email-check",
        data: {
          "email": email,
        },
      );
      if (response == null) {
        return throw const ServerException('Something went wrong!');
      }
      return EmailModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        "${Endpoints.auth}/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String displayName,
    required int age,
    required String? gender,
  }) async {
    try {
      final response = await _dioClient.post(
        "${Endpoints.auth}/register",
        data: {
          "email": email,
          "password": password,
          "displayName": displayName,
          "age": age,
          "gender": gender,
        },
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
