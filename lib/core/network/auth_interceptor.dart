import 'package:dio/dio.dart';

// Project Config
import 'package:sfrigola/core/config/app_config.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_storage.dart';

class AuthInterceptor extends Interceptor {
  final void Function()? onSessionExpired;

  AuthInterceptor({this.onSessionExpired});

  String _createTokenHeader(String token) => 'Bearer $token';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AppStorage.instance.read(AppConfig.storageKeyAuthToken);
    if (token != null) {
      options.headers['Authorization'] = _createTokenHeader(token);
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      // Global bucket (JWT_EXPIRED, JWT_VALIDATION_FAILED, NOT_AUTHORIZED,
      // NO_USER_AUTH, ENV_NOT_AVAILABLE) — token is dead regardless of which
      // specific code fired. No need to branch on errorMessageMap.
      await AppStorage.instance.delete(AppConfig.storageKeyAuthToken);
      onSessionExpired?.call();
    }
    // 403 deliberately NOT handled here — user is still authenticated, just
    // denied for this specific action. No session side-effect; surfaced as a
    // normal error by the unwrap helper using errorMessageMap.
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Reaches here only for genuine transport failures (timeout, no
    // connection) — validateStatus:true means 4xx/5xx never throw.
    handler.next(err);
  }
}
