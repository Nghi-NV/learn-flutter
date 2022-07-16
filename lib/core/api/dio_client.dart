import 'package:dio/dio.dart';
import 'package:learn_flutter/core/api/dio_interceptor.dart';
import 'package:learn_flutter/core/api/utils.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    setupDio();
  }

  void setupDio() {
    _dio = Dio();
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio.options = options;

    // _dio.interceptors.addAll([
    //   DioInterceptor(),
    // ]);
  }

  Dio get dio => _dio;
}
