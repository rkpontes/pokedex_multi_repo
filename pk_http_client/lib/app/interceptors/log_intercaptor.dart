import 'package:flutter/foundation.dart';
import 'package:pk_shared/dependencies/dio.dart';

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("### HTTP LOG INTERCEPTOR REQUEST: ###");
    debugPrint("METHOD: ${options.method}");
    debugPrint("URI: ${options.uri}");
    debugPrint("HEADERS: ${options.headers}");
    debugPrint("DATA: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("### HTTP LOG INTERCEPTOR RESPONSE: ###");
    debugPrint("${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("### HTTP LOG INTERCEPTOR ERROR: ###");
    debugPrint("${err.error}");
    super.onError(err, handler);
  }
}
