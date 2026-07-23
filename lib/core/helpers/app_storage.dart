import 'dart:convert';

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

  /// Reads a JSON-encoded object and deserializes it with [fromJson].
  /// Returns null if the key does not exist.
  Future<T?> readObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final raw = await _storage.read(key: key);
    if (raw == null) return null;
    return fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  /// Serializes [value] with [toJson] and stores it as a JSON string.
  Future<void> writeObject<T>(
    String key,
    T value,
    Map<String, dynamic> Function(T) toJson,
  ) => _storage.write(key: key, value: jsonEncode(toJson(value)));
}
