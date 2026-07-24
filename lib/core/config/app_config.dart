import 'dart:io';

enum AppEnvironment { development, production }

class AppConfig {
  AppConfig._();

  static const AppEnvironment env = AppEnvironment.development;

  static const String _devBaseUrlIosSimulator =
      'http://localhost:8080/sfrigola-core';
  static const String _devBaseUrlAndroidEmulator =
      'http://10.0.2.2:8080/sfrigola-core';
  static const String _prodBaseUrl = 'https://api.sfrigola.com/sfrigola-core';

  static String get baseUrl => switch (env) {
    AppEnvironment.development =>
      Platform.isAndroid ? _devBaseUrlAndroidEmulator : _devBaseUrlIosSimulator,
    AppEnvironment.production => _prodBaseUrl,
  };

  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  static const String storageKeyAuthToken = 'auth_token';
}
