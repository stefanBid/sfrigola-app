---
applyTo: "**/helpers/**,**/models/**"
---

# Helpers — Design system files

Fixed filenames — do not add new files without a real need:

| File | Purpose |
|---|---|
| `app_colors.dart` | Colour tokens |
| `app_typography.dart` | Text styles |
| `app_design.dart` | Spacing, border radius, padding |
| `app_theme.dart` | MaterialApp theme configuration |
| `app_router.dart` | Typed navigation layer |
| `app_locale.dart` | Localisation config and labels shorthand |
| `app_validation.dart` | Form field validators |
| `app_logger.dart` | Debug-only logger (stripped in release) |

`lib/core/utils/` contains shared utilities that don't belong to the design system:

| File | Purpose |
|---|---|
| `provider_retry.dart` | `appRetry` — shared Riverpod retry function |
| `be_simulators.dart` | Static mock-BE layer — owns all data simulation logic used by repositories |

`lib/core/models/be-models/` contains the typed response wrappers that mirror the real BE contract:

| File | Class(es) | When to use |
|---|---|---|
| `be_error.dart` | `BeError` | Error shape embedded in any response |
| `get_response.dart` | `GetDataResponse<T>`, `GetListDataResponse<T>` | GET endpoints (single resource or paginated list) |
| `mutation_response.dart` | `MutationResponse` | POST, PUT, PATCH, DELETE endpoints |

---

## AppLocale — `lib/core/helpers/app_locale.dart`

Central localisation configuration. Use in `MaterialApp.router` and to access translated strings anywhere in the app.

```dart
// In main.dart / MaterialApp.router
supportedLocales: AppLocale.supportedLocales,
localizationsDelegates: AppLocale.localizationsDelegates,
locale: const Locale('it'),
```

Access translated strings via the `getLabels` shorthand — **never** call `AppLocalizations.of(context)!` directly:

```dart
final l = AppLocale.getLabels(context);
Text(l.homeTitle)
Text(l.homeSearchHint)
```

ARB source files are in `lib/core/l10n/`:
- `app_it.arb` — Italian (template / default)
- `app_en.arb` — English

When adding a new string: add it to **both** ARB files, then run `flutter gen-l10n`.

### Error localisation — `AppLocale.errorFor`

Static method on `AppLocale` that resolves any thrown object into a user-facing string:

```dart
// In ref.listen, catch blocks, etc.
AppLocale.errorFor(context, error)
```

- If `error` is an `AppException` → calls `error.localizedMessage(AppLocale.getLabels(context))` directly
- Anything else → falls back to `l.errorGeneric`

**Never use `errorForCode` — it no longer exists.** Each exception owns its message.

---

## Exception system — `lib/core/models/general_exception.dart`

### `AppException` interface

All domain exceptions **must** implement this interface:

```dart
abstract interface class AppException implements Exception {
  String localizedMessage(AppLocalizations l);
  bool get isRetryable;
}
```

- Import `package:sfrigola/core/l10n/app_localizations.dart` in exception files.
- `localizedMessage` must return the appropriate ARB string for that specific exception.
- `isRetryable` must return `false` for all domain/logic exceptions (not found, unauthorized, etc.).
- Do **not** use `AppErrorCode` in the interface contract — it is internal to `GeneralException`.

### `GeneralException` — general-purpose exception

Use when no specific domain exception exists:

```dart
throw GeneralException.network(cause: e);
throw GeneralException.serverError(cause: e);
throw GeneralException.generic(cause: e);
// + notFound, unauthorized, forbidden
```

`GeneralException` stores an `AppErrorCode` internally and maps it to ARB strings via an internal switch. The `cause` field preserves the original error for logging. `isRetryable` returns `true` only for `network` and `serverError`.

The shared retry function lives in `lib/core/utils/provider_retry.dart`. It is registered globally in `ProviderScope` — do **not** import it in individual providers.

```dart
// main.dart — global retry policy (already configured, do not change)
ProviderScope(
  retry: appRetry,
  ...
)
```

### Domain-specific exceptions

Preferred over `GeneralException` when a specific, named failure exists:

```dart
class MealNotFoundException implements AppException {
  const MealNotFoundException(this.id);
  final String id;

  @override
  bool get isRetryable => false;

  @override
  String localizedMessage(AppLocalizations l) => l.mealNotFoundError;
}
```

Add a dedicated ARB key (e.g. `mealNotFoundError`) with a specific, context-aware message instead of reusing a generic error string.

---

## AppValidation — `lib/core/helpers/app_validation.dart`

Static validators for `TextFormField` / `BaseFormField`. Returns `null` if valid, an error string if invalid.

Chain with `??` — first failure wins:

```dart
validator: (v) => AppValidation.notEmpty(v) ?? AppValidation.email(v),
```

### Methods

| Method | Validates |
|---|---|
| `notEmpty(v)` | Field is not null or empty |
| `email(v)` | Valid email format |
| `minLength(v, n)` | At least n characters |
| `maxLength(v, n)` | At most n characters |
| `match(v, other)` | Values match (e.g. confirm password) |
| `numeric(v)` | Digits only |
| `strongPassword(v)` | Has uppercase + lowercase + digit |

All methods accept an optional `message` parameter to override the default error string.

### Common patterns

```dart
// Required only
validator: (v) => AppValidation.notEmpty(v),

// Required + valid email
validator: (v) => AppValidation.notEmpty(v) ?? AppValidation.email(v),

// Strong password
validator: (v) =>
    AppValidation.notEmpty(v) ??
    AppValidation.minLength(v, 8) ??
    AppValidation.strongPassword(v),

// Confirm password
validator: (v) =>
    AppValidation.notEmpty(v) ??
    AppValidation.match(v, passwordController.text),
```

---

## AppLogger — `lib/core/helpers/app_logger.dart`

Debug-only logger gated behind `kDebugMode`. All output is **automatically stripped in release and profile builds** — never use `print()` or bare `debugPrint()` directly.

```dart
import 'package:sfrigola/core/helpers/app_logger.dart';

AppLogger.debug('User loaded', tag: 'HomeScreen');
AppLogger.warn('Token is about to expire');
AppLogger.error('Failed to fetch data', error: e, stackTrace: st);
```

### Methods

| Method | Level | When to use |
|---|---|---|
| `AppLogger.debug(message, {tag})` | `[D]` | General flow information |
| `AppLogger.warn(message, {tag})` | `[W]` | Non-critical anomalies |
| `AppLogger.error(message, {tag, error, stackTrace})` | `[E]` | Exceptions and failures |

- `tag` is optional — use it to identify the calling class or feature (e.g. `tag: 'AuthService'`).
- `error` and `stackTrace` are optional extra fields on `AppLogger.error`.
- Output format: `[D] Tag | message` or `[D] message` when tag is omitted.

### Rules
- **Never use `print()`** anywhere in the project. Always use `AppLogger`.
- **Never use `debugPrint()` directly** — `AppLogger` calls it internally with the `kDebugMode` guard.
- Do not wrap calls in manual `if (kDebugMode)` checks — `AppLogger` handles that internally.
