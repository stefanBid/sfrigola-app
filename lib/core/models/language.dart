// Project Models
import 'package:sfrigola/core/models/json_serializable.dart';

/// Mirrors the backend's `LanguageDto` record:
/// ```java
/// public record LanguageDto(
///     String code,
///     String name
/// ) implements Serializable {}
/// ```
class Language implements JsonSerializable {
  final String code;
  final String name;

  const Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    code: json['code'] as String,
    name: json['name'] as String,
  );

  @override
  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}
