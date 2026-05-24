import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// App-wide singleton for secure key-value storage.
///
/// Uses [FlutterSecureStorage] under the hood:
/// - Android: EncryptedSharedPreferences
/// - iOS: Keychain (accessible after first unlock)
///
/// Usage:
/// ```dart
/// await AppStorage.instance.write('token', value);
/// final token = await AppStorage.instance.read('token');
/// await AppStorage.instance.delete('token');
/// ```
class AppStorage {
  AppStorage._();

  static final AppStorage instance = AppStorage._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<void> delete(String key) => _storage.delete(key: key);
}
