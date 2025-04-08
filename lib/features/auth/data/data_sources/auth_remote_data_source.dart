import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/auth/data/models/user_model.dart';
import 'package:soundspace/features/auth/data/models/user_profile_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUp({
    required String email,
    required String password,
  });
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<String> emailValidation({
    required String email,
  });

  Future<String> createProfile({
    required String displayName,
    required int age,
    required String gender,
  });

  Future<ProfileModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dio;
  static const storage = FlutterSecureStorage();
  AuthRemoteDataSourceImpl(
    this._dio,
  );

  @override
  Future<ProfileModel?> getCurrentUserData() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.user}/get-user",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        return throw const ServerException('User not logged in!');
      } else {
        throw const ServerException('Something went wrong!');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> emailValidation({
    required String email,
  }) async {
    try {
      Response response = await _dio.post(
        "${Endpoints.auth}/email-valid",
        data: {
          "email": email,
        },
      );
      if (response.statusCode == 200) {
        return email;
      } else if (response.statusCode == 400) {
        return response.data['message'];
      } else {
        throw const ServerException('Something went wrong!');
      }
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
      Response response = await _dio.post(
        "${Endpoints.auth}/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        await storage.write(key: 'token', value: response.data['token']);
        return UserModel.fromJson(response.data);
      } else {
        throw const ServerException('Something went wrong!');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _dio.post(
        "${Endpoints.auth}/create",
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return "Create account success";
      } else {
        throw const ServerException('Something went wrong!');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> createProfile({
    required String displayName,
    required int age,
    required String gender,
  }) async {
    try {
      Response response = await _dio.post(
        "${Endpoints.user}/create",
        options: Options(headers: {
          "accept": "multipart/form-data; charset=utf-8",
        }),
        data: FormData.fromMap({
          "displayName": displayName,
          "age": age,
          "gender": gender,
          "image": await MultipartFile.fromFile(
            'assets/images/default_avatar.jpg', // Replace with the actual image path
            filename: 'default_avatar.jpg', // Replace with the desired filename
          ),
        }),
      );
      if (response.statusCode == 200) {
        return "Create profile success";
      } else {
        throw const ServerException('Something went wrong!');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
