// Project Models
import 'package:sfrigola/core/models/be-models/be_error_data.dart';

/// Mirrors the backend's `SCGeneralResponseDto<T, K>` record:
/// ```java
/// public record SCGeneralResponseDto<T, K>(
///     T data,
///     K option,
///     SCErrorDataDto errorData
/// ) implements Serializable {}
/// ```
/// On success (2xx) `data` is populated and `errorData` is null.
/// On error (non-2xx) `data` is null and `errorData` is populated.
class BeGeneralResponse<T, K> {
  final T? data;
  final K? option;
  final BeErrorData? errorData;

  const BeGeneralResponse({this.data, this.option, this.errorData});

  /// [dataFromJson] and [optionFromJson] receive the raw decoded JSON value
  /// as-is — a `Map<String, dynamic>` when `data`/`option` is a single object,
  /// a `List<dynamic>` when it's a collection. Cast/iterate at the call site,
  /// e.g. for a list: `(raw) => (raw as List).map((e) => Category.fromJson(e as Map<String, dynamic>)).toList()`.
  factory BeGeneralResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? raw) dataFromJson, {
    K Function(Object? raw)? optionFromJson,
  }) {
    return BeGeneralResponse(
      data: json['data'] == null ? null : dataFromJson(json['data']),
      option: (json['option'] == null || optionFromJson == null)
          ? null
          : optionFromJson(json['option']),
      errorData: json['errorData'] == null
          ? null
          : BeErrorData.fromJson(json['errorData'] as Map<String, dynamic>),
    );
  }
}
