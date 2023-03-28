import 'package:dio/dio.dart';

import '../../../data/endpoints/endpoints.dart';

abstract class NetowrkModule {
  static Dio provideDio() {
    final dio = Dio();

    dio
      ..options.baseUrl = AppEndpoints.baseUrl
      ..options.connectTimeout = AppEndpoints.connectionTimeout
      ..options.receiveTimeout = AppEndpoints.receiveTimeout;
    dio.interceptors.clear();

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
      ),
    ]);

    return dio;
  }
}
