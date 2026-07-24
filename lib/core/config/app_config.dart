import 'dart:io';

enum AppEnvironment { development, production }

class AppConfig {
  AppConfig._();

  static const AppEnvironment env = AppEnvironment.development;

  static const String _devBaseUrlIosSimulator =
      'http://localhost:8080/sfrigola-core/api';
  static const String _devBaseUrlAndroidEmulator =
      'http://10.0.2.2:8080/sfrigola-core/api';
  static const String _prodBaseUrl =
      'https://api.sfrigola.com/sfrigola-core/api';

  static String get baseUrl => switch (env) {
    AppEnvironment.development =>
      Platform.isAndroid ? _devBaseUrlAndroidEmulator : _devBaseUrlIosSimulator,
    AppEnvironment.production => _prodBaseUrl,
  };

  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  static const String storageKeyAuthToken = 'auth_token';

  // API versioning — mirrors the BE's ApiVersionConfigurer
  // (useMediaTypeParameter): the version travels as the `v` parameter on the
  // Accept header's media type, e.g. "application/vnd.sfrigola+json;v=1.0".
  // Bump [apiVersion] here when the app targets a newer BE API version; a
  // single call site can still override it via `Options(headers: {...})`.
  static const String _apiMediaType = 'application/vnd.sfrigola+json';
  static const String _apiVersion = '1.0';

  static String get apiAcceptHeader => '$_apiMediaType;v=$_apiVersion';
}
