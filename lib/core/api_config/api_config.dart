import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:innovins_task/core/endpoints/endpoints.dart';

class ApiConfig {
  late final Dio dio;
  late final BaseOptions baseOptions;

  init() {
    dio = Dio();
    baseOptions = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      receiveTimeout: const Duration(seconds: 40),
      sendTimeout: const Duration(seconds: 40),
      connectTimeout: const Duration(seconds: 40),
      responseType: ResponseType.json,
      maxRedirects: 10,
    );
    dio.options = baseOptions;
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        responseHeader: false,
        requestBody: true,
        request: true,
        requestHeader: true,
        error: true,
        logPrint: (text) {
          log(text.toString());
        }));
  }

  setAuthToken(String token) {
    baseOptions.headers.addAll({"X-API-Key": token});
  }
}
