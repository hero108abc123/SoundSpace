import 'package:dio/dio.dart';

import '../constants/endpoints.dart';

abstract class NetworkModule {
  static Dio provideDio() {
    final dio = Dio();
    dio
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.baseUrl = Endpoints.baseUrl
      ..options.headers = {'Context-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    return dio;
  }
}
