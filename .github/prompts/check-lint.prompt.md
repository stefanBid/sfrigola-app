---
agent: agent
description: 'Run a full code quality check: auto-fix warnings, hints and info following Flutter best practices; report blocking errors for manual review.'
---

# Workflow — Code Quality Check

> **Trigger phrase**: "check del progetto", "verifica la qualità del codice", "il progetto è pulito?", "fai un lint check" or any clearly equivalent phrase.

> **Required mode: Agent.**
> If you do not have access to file system tools (you are in Ask Mode / Chat Mode), reply **only** with:
> "Per eseguire il check del codice devo essere in modalità **Agent**. Ri-lancia la richiesta in Agent mode."
> Then stop. Do not attempt the workflow.

---

## Linter context

This project enforces the following rules on top of `package:flutter_lints/flutter.yaml`:

```yaml
rules:
  prefer_const_constructors: true
  prefer_const_literals_to_create_immutables: true
```

Every fix must comply with these rules and with Flutter/Dart best practices. **Never silence an issue with `// ignore` or `// ignore_for_file` comments.** Issues must be fixed in code, not hidden.

---

## Auto-fix rules

Apply the following fixes automatically whenever they are encountered. Use `read_file` to understand context before editing, then use `replace_string_in_file` / `multi_replace_string_in_file` to apply changes.

### `const` — add where missing (`prefer_const_constructors`, `prefer_const_literals_to_create_immutables`)
- Add `const` to constructor calls and list/map/set literals that can be compile-time constants.
- Move `const` to the outermost eligible ancestor when possible (do not repeat it on children already covered by a parent `const`).

### `const` — remove where unnecessary
- Remove `const` from expressions that cannot be compile-time constants (e.g. they reference non-const variables or context-dependent values).

### `print` statements
- Remove any `print(...)` call found anywhere in the project.
- Replace any `debugPrint(...)` call that is **not** inside `AppLogger` with the equivalent `AppLogger.debug(...)` / `AppLogger.warn(...)` / `AppLogger.error(...)` call, choosing the level that best matches the context.
- Never wrap replacements in a manual `if (kDebugMode)` check — `AppLogger` handles that internally.
- Import `app_logger.dart` with a relative path at the top of the file if not already imported.

### Unused imports / variables
- Remove any import or variable that the analyser flags as unused.

### Other `info` and `hint` diagnostics
- Fix all `info •` and `hint •` lines following the same principle: apply the correct code change according to Flutter best practices. Do not silence them.

---

## Step 1 — Dart fix (safe auto-fixes)

Run the following command to detect fixable issues:

```
dart fix --dry-run
```

If the output contains fixable items, apply them automatically:

```
dart fix --apply
```

Record how many fixes were applied (or "none" if the dry-run was clean).

---

## Step 2 — Dart format

Run the format check:

```
dart format --output=none --set-exit-if-changed .
```

If the exit code is non-zero (files need formatting), apply the formatting automatically:

```
dart format .
```

Record which files were reformatted (or "none" if already clean).

---

## Step 3 — Flutter analyze

Run the static analyser:

```
flutter analyze
```

Parse the full output and categorise every diagnostic:

### Category A — Auto-fixable (warnings, info, hints)
`warning •`, `info •`, `hint •` lines that fall under the auto-fix rules above.

**Fix all of them in code** following the rules in the "Auto-fix rules" section. After applying all fixes, re-run `flutter analyze` to confirm they are resolved.

### Category B — Errors (manual review required)
`error •` lines — **blocking issues** that prevent compilation. **Do not attempt to fix these automatically.** List each one with:
- File path and line number
- Error code
- Description

Present them clearly to the user for manual intervention.

---

## Step 4 — Report to the user

Provide a concise summary in Italian structured as follows:

```
## Risultato check qualità

### ✅ Fix applicati automaticamente
- dart fix: X fix applicati
- dart format: X file riformattati

### ❌ Errori (intervento richiesto)
- path/to/file.dart:42 — error_code: Descrizione

### ⚠️ Warning (da valutare)
- path/to/file.dart:15 — warning_code: Descrizione

### ℹ️ Info / hint
- N hint trovati (elenca solo se > 0)

### 🎯 Stato finale
Progetto pulito / Progetto con X errori da risolvere
```

If there are **no errors and no warnings**, close with:
> "Il progetto è pulito. Nessun intervento manuale richiesto."
