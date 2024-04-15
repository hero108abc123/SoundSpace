import 'package:dio/dio.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';

abstract class NetworkModule {
  static Dio provideDio() {
    final dio = Dio();
    dio
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
