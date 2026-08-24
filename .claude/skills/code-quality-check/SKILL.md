---
name: code-quality-check
description: Run the Sfrigola app's code quality pass (dart fix, format, analyze). Use when asked to check code quality, clean up lint issues, or run a formatting/analysis pass.
---

1. `dart fix --dry-run` then `dart fix --apply`.
2. `dart format --output=none --set-exit-if-changed .` then `dart format .` if needed.
3. `flutter analyze` — fix all warnings/hints, report errors for manual review.
4. Never silence issues with `// ignore` — fix in code.
5. Auto-fix rules: add missing `const`, remove unnecessary `const`, replace `print`/`debugPrint` with `AppLogger`, remove unused imports.
