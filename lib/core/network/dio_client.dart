import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Provider
import 'package:sfrigola/core/providers/current_user_provider.dart';

// Project Config
import 'package:sfrigola/core/config/app_config.dart';

// Project Network
import 'package:sfrigola/core/network/auth_interceptor.dart';

Dio buildDioClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: AppConfig.connectionTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      // The backend's global error handler always returns a BeGeneralResponse
      // body (data null / errorData populated) even on 4xx/5xx — never let
      // Dio throw on those, or the body is lost inside a DioException instead
      // of being parsed normally by the repository.
      validateStatus: (_) => true,
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(
      onSessionExpired: () => ref.invalidate(currentUserProvider),
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }

  return dio;
}
