---
name: localise-strings
description: Add or update localised strings in the Sfrigola app (ARB files + AppLocale). Use when asked to localise, translate, or internationalise hardcoded strings in a Dart file.
---

When asked to localise strings:
1. Read `lib/core/l10n/` to discover ARB files.
2. Scan target file for hardcoded user-visible strings (exclude comments, log strings, IDs, strings already through `AppLocale.getLabels`).
3. Derive camelCase keys scoped with screen prefix (e.g. `homeTitle`, `recipeDetailIngredients`).
4. Add keys to **all** ARB files — every key must exist in every language.
5. Replace in Dart file: `AppLocale.getLabels(context).myKey` — remove `const` from ancestor if needed.
6. Run `flutter gen-l10n` (NOT `dart run build_runner build`).
7. Run `flutter analyze --no-pub` and fix issues.
