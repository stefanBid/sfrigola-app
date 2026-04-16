---
applyTo: "**/helpers/**"
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

---

## AppLocale — `lib/helpers/app_locale.dart`

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

ARB source files are in `lib/l10n/`:
- `app_it.arb` — Italian (template / default)
- `app_en.arb` — English

When adding a new string: add it to **both** ARB files, then run `flutter gen-l10n`.

---

## AppValidation — `lib/helpers/app_validation.dart`

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

## AppLogger — `lib/helpers/app_logger.dart`

Debug-only logger gated behind `kDebugMode`. All output is **automatically stripped in release and profile builds** — never use `print()` or bare `debugPrint()` directly.

```dart
import '../helpers/app_logger.dart';

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
