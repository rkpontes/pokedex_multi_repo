import 'package:pk_shared/dependencies/dio.dart';

class AutorizationInterceptor extends Interceptor {
  AutorizationInterceptor();

  final String token = "my_token";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
