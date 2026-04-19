// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

enum AppErrorCode {
  network,
  notFound,
  unauthorized,
  forbidden,
  serverError,
  generic,
}

abstract interface class AppException implements Exception {
  String localizedMessage(AppLocalizations l);
  bool get isRetryable;
}

class GeneralException implements AppException {
  final AppErrorCode code;
  final Object? cause;

  const GeneralException(this.code, {this.cause});

  factory GeneralException.network({Object? cause}) =>
      GeneralException(AppErrorCode.network, cause: cause);

  factory GeneralException.notFound({Object? cause}) =>
      GeneralException(AppErrorCode.notFound, cause: cause);

  factory GeneralException.unauthorized({Object? cause}) =>
      GeneralException(AppErrorCode.unauthorized, cause: cause);

  factory GeneralException.forbidden({Object? cause}) =>
      GeneralException(AppErrorCode.forbidden, cause: cause);

  factory GeneralException.serverError({Object? cause}) =>
      GeneralException(AppErrorCode.serverError, cause: cause);

  factory GeneralException.generic({Object? cause}) =>
      GeneralException(AppErrorCode.generic, cause: cause);

  @override
  bool get isRetryable => switch (code) {
    AppErrorCode.network || AppErrorCode.serverError => true,
    _ => false,
  };

  @override
  String localizedMessage(AppLocalizations l) => switch (code) {
    AppErrorCode.network => l.errorNetwork,
    AppErrorCode.notFound => l.errorNotFound,
    AppErrorCode.unauthorized => l.errorUnauthorized,
    AppErrorCode.forbidden => l.errorForbidden,
    AppErrorCode.serverError => l.errorServerError,
    AppErrorCode.generic => l.errorGeneric,
  };

  @override
  String toString() => 'GeneralException(${code.name})';
}
