/// Every `errorMessageMap` key the backend can send, grouped by HTTP status
/// bucket. Keeping these as named constants instead of inline string literals
/// avoids typos and keeps this file as the single place to update when the
/// backend adds/renames a code.
///
/// Global buckets (401, 5xx) are handled once, centrally — the calling screen
/// never reads these. Case-by-case buckets (400, 403, 404, 409) are never
/// intercepted — the calling screen reads `errorData.errorMessageMap`'s key
/// and reacts specifically (inline field error, "not found" empty state,
/// "already exists" message, disabled-action message, etc.).
class AppExceptionCodes {
  AppExceptionCodes._();

  // ---------------------------------------------------------------------
  // 500 — server fault, global bucket (never shown to the user individually)
  // ---------------------------------------------------------------------
  static const serverError = 'SERVER_ERROR'; // generic fallback
  static const noRowsAffected = 'NO_ROWS_AFFECTED';
  static const dataCorrupted = 'DATA_CORRUPTED';
  static const securitySystemError = 'SECURITY_SYSTEM_ERROR';
  static const invalidRoleFromString = 'INVALID_ROLE_FROM_STRING';

  // ---------------------------------------------------------------------
  // 401 — session/token invalid, global bucket
  // ---------------------------------------------------------------------
  static const envNotAvailable = 'ENV_NOT_AVAILABLE';
  static const jwtExpired = 'JWT_EXPIRED';
  static const jwtValidationFailed = 'JWT_VALIDATION_FAILED';
  static const noUserAuth = 'NO_USER_AUTH'; // token valid, user gone
  // notAuthorized (below) is shared with the 403 bucket — same string, the
  // HTTP status code (not the code string) disambiguates which case it is.

  // ---------------------------------------------------------------------
  // 403 — authenticated but not allowed, case-by-case
  // ---------------------------------------------------------------------
  static const notAuthorized =
      'NOT_AUTHORIZED'; // Spring Security role/path denial (403) — also used at 401 for "no auth on protected route"
  static const userNotActive = 'USER_NOT_ACTIVE';
  static const notRecipeOwner = 'NOT_RECIPE_OWNER';
  static const cannotChangeRoleToAdmin = 'CANNOT_CHANGE_ROLE_TO_ADMIN';
  static const cannotChangeOwnActiveStatus = 'CANNOT_CHANGE_OWN_ACTIVE_STATUS';

  // ---------------------------------------------------------------------
  // 404 — resource not found, case-by-case
  // ---------------------------------------------------------------------
  static const entityNotFound = 'ENTITY_NOT_FOUND'; // generic fallback
  static const selectedCategoryNotFound = 'SELECTED_CATEGORY_NOT_FOUND';
  static const tagNotFound = 'TAG_NOT_FOUND';
  static const recipeNotFound = 'RECIPE_NOT_FOUND';
  static const ingredientNotFound = 'INGREDIENT_NOT_FOUND';
  static const userNotFound = 'USER_NOT_FOUND';
  static const favoriteNotFound = 'FAVORITE_NOT_FOUND';
  static const ratingNotFound = 'RATING_NOT_FOUND';

  // ---------------------------------------------------------------------
  // 409 — resource already exists, case-by-case
  // ---------------------------------------------------------------------
  static const userAlreadyExists = 'USER_ALREADY_EXISTS';
  static const categorySlugAlreadyExists = 'CATEGORY_SLUG_ALREADY_EXISTS';
  static const tagSlugAlreadyExists = 'TAG_SLUG_ALREADY_EXISTS';
  static const tagLabelAlreadyExists = 'TAG_LABEL_ALREADY_EXISTS';
  static const ingredientSlugAlreadyExists = 'INGREDIENT_SLUG_ALREADY_EXISTS';
  static const favoriteAlreadyExists = 'FAVORITE_ALREADY_EXISTS';
  static const ratingAlreadyExists = 'RATING_ALREADY_EXISTS';

  // ---------------------------------------------------------------------
  // 400 — validation & business-rule violations, case-by-case
  // ---------------------------------------------------------------------
  static const malformedJson = 'MALFORMED_JSON';
  static const illegalArgument = 'ILLEGAL_ARGUMENT';
  static const invalidEnumCode = 'INVALID_ENUM_CODE';
  static const badCredentials =
      'BAD_CREDENTIALS'; // wrong email/password on login — deliberately not 401
  static const newPasswordSameAsOldPassword =
      'NEW_PASSWORD_SAME_AS_OLD_PASSWORD';
  static const passwordDoesNotMatchConfirmationPassword =
      'PASSWORD_DOES_NOT_MATCH_CONFIRMATION_PASSWORD';
  static const compromisedPassword = 'COMPROMISED_PASSWORD';
  static const oldPasswordNotMatch = 'OLD_PASSWORD_NOT_MATCH';
  static const localeNotActive = 'LOCALE_NOT_ACTIVE';
  static const invalidLangCode = 'INVALID_LANG_CODE';
  static const categoryHasChildren = 'CATEGORY_HAS_CHILDREN';
  static const categoryReorderMismatch = 'CATEGORY_REORDER_MISMATCH';
  static const tagScopeNotAllowed = 'TAG_SCOPE_NOT_ALLOWED';
  static const contributorTranslationLimitExceeded =
      'CONTRIBUTOR_TRANSLATION_LIMIT_EXCEEDED';

  // Per-field Jakarta Validation messages have no fixed code — the field name
  // itself is the errorMessageMap key, not enumerable here.
  //
  // MISSING_*_LOCALES / DUPLICATE_*_LOCALE have a dynamic locale suffix
  // (e.g. MISSING_IT_LOCALE) — match with `.startsWith('MISSING_')` /
  // `.startsWith('DUPLICATE_')` at the call site instead of an exact constant.
  static const missingLocalesPrefix = 'MISSING_';
  static const duplicateLocalePrefix = 'DUPLICATE_';
}
