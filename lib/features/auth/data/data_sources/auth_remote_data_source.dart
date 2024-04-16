import 'package:dio/dio.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/auth/data/models/email_model.dart';
import 'package:soundspace/features/auth/data/models/user_model.dart';
import 'package:soundspace/features/auth/domain/repositories/token_repository.dart';

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
  final TokenRepository _tokenRepository;
  final DioClient _dioClient;
  AuthRemoteDataSourceImpl(
    this._dioClient,
    this._tokenRepository,
  );

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final token = _tokenRepository.getToken();
      final response = await _dioClient.get(
        "${Endpoints.auth}/current-user",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response == null) {
        throw const ServerException('Unauthorize!');
      }
      return UserModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
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
      if (response.statusCode == 401) {
        throw const ServerException('User is null!');
      }
      await _tokenRepository.saveToken(response.data['token']);
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
      await _tokenRepository.deleteToken();
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
