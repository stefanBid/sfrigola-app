// Project Models
import 'package:sfrigola/core/models/be-models/be_error_data.dart';
import 'package:sfrigola/core/models/app_exception.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/user.dart';

// Project Network
import 'package:sfrigola/core/network/app_exception_codes.dart';

/// Translates a [BeErrorData] (already parsed from a `BeGeneralResponse`)
/// into an [AppException], following the backend's error code legend.
///
/// Buckets `401` and `500` are "global" — every code inside them means the
/// same thing to the client regardless of which one fired, so `errorData`'s
/// `errorMessageMap` key is not inspected for those. Buckets `403`, `404`,
/// `409` and `400` are "case-by-case" — the first key in `errorMessageMap`
/// is checked against known codes and mapped to an existing domain exception
/// when one exists; everything else in that bucket falls back to the
/// matching generic [AppErrorCode].
AppException mapBeError(BeErrorData errorData) {
  final keys = errorData.errorMessageMap.keys;
  final code = keys.isEmpty ? null : keys.first;

  return switch (errorData.statusCode) {
    // Global bucket — session/token invalid regardless of which code fired:
    // envNotAvailable, jwtExpired, jwtValidationFailed, notAuthorized,
    // noUserAuth. See AuthInterceptor.onResponse for the actual side-effect
    // (logout) — this mapper only produces the exception.
    401 => AppException.unauthorized(beErrorData: errorData),

    // Global bucket — server fault, never shown to the user individually:
    // serverError, noRowsAffected, dataCorrupted, securitySystemError,
    // invalidRoleFromString.
    500 => AppException.serverError(beErrorData: errorData),

    // Case-by-case — user IS authenticated, just not allowed for this action:
    // notAuthorized (role/path denial), userNotActive, notRecipeOwner,
    // cannotChangeRoleToAdmin, cannotChangeOwnActiveStatus.
    // No dedicated domain exception yet for any of these — add one here as
    // each case needs a distinct message.
    403 => AppException.forbidden(beErrorData: errorData),

    404 => switch (code) {
      AppExceptionCodes.recipeNotFound => MealNotFoundException(
        errorData.apiPath,
      ),
      // entityNotFound (generic fallback), selectedCategoryNotFound,
      // tagNotFound, ingredientNotFound, userNotFound, favoriteNotFound,
      // ratingNotFound — no dedicated exception yet.
      _ => AppException.notFound(beErrorData: errorData),
    },

    409 => switch (code) {
      AppExceptionCodes.userAlreadyExists => const EmailAlreadyInUseException(),
      // categorySlugAlreadyExists, tagSlugAlreadyExists,
      // tagLabelAlreadyExists, ingredientSlugAlreadyExists,
      // favoriteAlreadyExists, ratingAlreadyExists — no dedicated exception
      // yet.
      _ => AppException.conflict(beErrorData: errorData),
    },

    400 => switch (code) {
      AppExceptionCodes.badCredentials => const InvalidCredentialsException(),
      AppExceptionCodes.oldPasswordNotMatch =>
        const WrongCurrentPasswordException(),
      AppExceptionCodes.compromisedPassword => const WeakPasswordException(),
      // Per-field Jakarta Validation messages, malformedJson,
      // illegalArgument, invalidEnumCode, newPasswordSameAsOldPassword,
      // passwordDoesNotMatchConfirmationPassword, localeNotActive,
      // invalidLangCode, missingLocalesPrefix/duplicateLocalePrefix,
      // categoryHasChildren, categoryReorderMismatch, tagScopeNotAllowed,
      // contributorTranslationLimitExceeded — no dedicated exception yet;
      // most of these are already caught client-side by AppValidation before
      // a request is even sent.
      _ => AppException.unmapped(beErrorData: errorData),
    },

    _ => AppException.unmapped(beErrorData: errorData),
  };
}
