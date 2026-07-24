/// Mirrors the backend's `SCCounterOptionDto` record:
/// ```java
/// public record SCCounterOptionDto(
///     Long count
/// ) implements Serializable {
///     public static SCCounterOptionDto of(Long count) {
///         return new SCCounterOptionDto(count);
///     }
///
///     public static final SCCounterOptionDto SINGLE_ELEMENT = new SCCounterOptionDto(1L);
/// }
/// ```
class BeCounterOption {
  final int? count;

  const BeCounterOption({required this.count});

  factory BeCounterOption.fromJson(Map<String, dynamic> json) =>
      BeCounterOption(count: json['count'] as int?);
}
