// Project Models
import 'package:sfrigola/core/models/be-models/be_error_data.dart';

// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

enum AppErrorCode {
  network,
  notFound,
  unauthorized,
  forbidden,
  conflict,
  serverError,

  /// The backend returned an error code with no dedicated client-side
  /// mapping yet — falls back to a generic localized message. A domain
  /// exception should be added instead as soon as this case needs its own
  /// precise wording.
  unmapped,
}

/// Base class for every exception the app throws. Domain-specific exceptions
/// (e.g. `MealNotFoundException` in `meal.dart`, `InvalidCredentialsException`
/// in `user.dart`) extend this rather than implementing a bare interface, so
/// they inherit [code] and [beErrorData] for free instead of faking fields
/// they don't otherwise need.
class AppException implements Exception {
  final AppErrorCode code;

  /// The raw backend error payload, when this exception originates from a
  /// parsed `BeGeneralResponse.errorData` (see `mapBeError` in
  /// `lib/core/network/be_error_mapper.dart`). Strongly typed so call sites
  /// never need an `is BeErrorData` check to inspect it — e.g.
  /// `exception.beErrorData?.errorMessageMap`.
  final BeErrorData? beErrorData;

  const AppException(this.code, {this.beErrorData});

  factory AppException.network({BeErrorData? beErrorData}) =>
      AppException(AppErrorCode.network, beErrorData: beErrorData);

  factory AppException.notFound({BeErrorData? beErrorData}) =>
      AppException(AppErrorCode.notFound, beErrorData: beErrorData);

  factory AppException.unauthorized({BeErrorData? beErrorData}) =>
      AppException(AppErrorCode.unauthorized, beErrorData: beErrorData);

  factory AppException.forbidden({BeErrorData? beErrorData}) =>
      AppException(AppErrorCode.forbidden, beErrorData: beErrorData);

  factory AppException.conflict({BeErrorData? beErrorData}) =>
      AppException(AppErrorCode.conflict, beErrorData: beErrorData);

  factory AppException.serverError({BeErrorData? beErrorData}) =>
      AppException(AppErrorCode.serverError, beErrorData: beErrorData);

  factory AppException.unmapped({BeErrorData? beErrorData}) =>
      AppException(AppErrorCode.unmapped, beErrorData: beErrorData);

  bool get isRetryable => switch (code) {
    AppErrorCode.network || AppErrorCode.serverError => true,
    _ => false,
  };

  String localizedMessage(AppLocalizations l) => switch (code) {
    AppErrorCode.network => l.errorNetwork,
    AppErrorCode.notFound => l.errorNotFound,
    AppErrorCode.unauthorized => l.errorUnauthorized,
    AppErrorCode.forbidden => l.errorForbidden,
    AppErrorCode.conflict => l.errorConflict,
    AppErrorCode.serverError => l.errorServerError,
    AppErrorCode.unmapped => l.errorUnmapped,
  };

  @override
  String toString() => 'AppException(${code.name})';
}
