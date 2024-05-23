import 'package:pk_http_client/app/client/http_client_base.dart';
import 'package:pk_shared/dependencies/dio.dart';
import 'package:pk_shared/shared/core/error/exception.dart';

enum RequestType { get }

const successCodes = [200, 201];

class HttpClient extends HttpClientBase {
  HttpClient(
    this.dio, {
    this.errorResponseMapper,
    this.interceptors = const [],
  }) {
    dio.options.connectTimeout = const Duration(milliseconds: 15000);
    dio.options.receiveTimeout = const Duration(milliseconds: 15000);

    for (var i in interceptors) {
      dio.interceptors.add(i);
    }
  }

  final Dio dio;
  final ServerException Function(Response<dynamic>? data)? errorResponseMapper;
  final List interceptors;

  @override
  Future get(String endpoint) =>
      _futureNetworkRequest(RequestType.get, endpoint, {});

  Future _futureNetworkRequest(
    RequestType type,
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      late Response response;
      switch (type) {
        case RequestType.get:
          response = await dio.get(endpoint);
          break;
        default:
          throw InvalidArgOrDataException();
      }
      if (successCodes.contains(response.statusCode)) {
        return response.data;
      }
      throw errorResponseMapper?.call(response) ??
          _serverErrorResponseMapper(response);
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw TimeoutServerException();
        }
        if (e is FormatException) {
          throw InvalidArgOrDataException();
        }
        if (e.response?.data != null) {
          throw errorResponseMapper?.call(e.response) ??
              _serverErrorResponseMapper(e.response);
        }
      }
      throw UnexpectedServerException();
    }
  }

  @override
  Future delete(String endpoint) {
    throw UnimplementedError();
  }

  @override
  Future patch(String endpoint, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future post(String endpoint, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future put(String endpoint, Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}

ServerException _serverErrorResponseMapper(Response<dynamic>? response) {
  final data = response?.data;
  if (data is Map) {
    if (data['message'] != null) return PokedexServerException(data['message']);
    if (data['error'] != null) return PokedexServerException(data['error']);
  }
  return UnexpectedServerException();
}
