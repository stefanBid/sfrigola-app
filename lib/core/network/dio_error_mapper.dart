import 'package:dio/dio.dart';

// Project Models
import 'package:sfrigola/core/models/app_exception.dart';

/// Maps genuine transport failures (no connection, timeout) to [AppException].
/// With `validateStatus: (_) => true` in dio_client.dart, this is the only
/// path DioException can take — 4xx/5xx from the backend never throw, they
/// arrive as a normal response parsed by `mapBeError` instead.
AppException mapDioError(DioException e) {
  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError => AppException.network(),
    DioExceptionType.badResponse => AppException.serverError(),
    _ => AppException.unmapped(),
  };
}
