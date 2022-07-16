import 'package:dio/dio.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {}

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {}
}
