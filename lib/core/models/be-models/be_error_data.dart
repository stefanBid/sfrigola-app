/// Mirrors the backend's `SCErrorDataDto` record:
/// ```java
/// public record SCErrorDataDto(
///     String apiPath,
///     HttpStatus status,
///     Map<String, String> errorMessageMap,
///     LocalDateTime errorTime
/// ) implements Serializable {}
/// ```
class BeErrorData {
  final String apiPath;
  final int statusCode;
  final Map<String, String> errorMessageMap;
  final DateTime errorTime;

  const BeErrorData({
    required this.apiPath,
    required this.statusCode,
    required this.errorMessageMap,
    required this.errorTime,
  });

  factory BeErrorData.fromJson(Map<String, dynamic> json) => BeErrorData(
    apiPath: json['apiPath'] as String,
    // HttpStatus serializes as "401 UNAUTHORIZED" — numeric code first.
    statusCode: int.parse((json['status'] as String).split(' ').first),
    errorMessageMap: Map<String, String>.from(
      json['errorMessageMap'] as Map? ?? {},
    ),
    errorTime: DateTime.parse(json['errorTime'] as String),
  );
}
