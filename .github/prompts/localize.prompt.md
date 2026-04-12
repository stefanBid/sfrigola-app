---
agent: agent
description: 'Localise hardcoded strings in a screen or across the project, or create a new language.'
---

# Workflow — Localisation

> **Required mode: Agent.**
> If you do not have access to file-system tools, reply **only** with:
> "Per eseguire la localizzazione devo essere in modalità **Agent**. Ri-lancia la richiesta in Agent mode."
> Then stop.

---

## Step 1 — Identify the task

Use `vscode_askQuestions` to ask the user which mode to run:

1. **Task** — What do you want to do?
   - Option A: Localise a specific screen / file (user will provide context or the file is already open)
   - Option B: Localise the entire project (all `.dart` files under `lib/`)
   - Option C: Add a new language

Do not proceed until the answer is received.

---

## Step 2A — Localise a specific screen or file

### 2A-1. Identify the target

If the user chose Option A:
- If a file is already open in the editor, use that as the target.
- If no file is open, ask the user to specify the file or screen name.

### 2A-2. Discover available ARB files

Read the `lib/l10n/` directory and list all `*.arb` files present (e.g. `app_it.arb`, `app_en.arb`).
The template ARB is `app_it.arb` (defined in `l10n.yaml`).

### 2A-3. Scan for hardcoded strings

Read the target file and collect every **user-visible hardcoded string**. Exclude:
- Code comments
- Debug/log strings
- Strings used only as keys, IDs, or identifiers
- Strings already going through `AppLocale.getLabels(context)`

For each found string, derive:
- A **camelCase key** that is semantic and scoped with the screen prefix (e.g. `homeTitle`, `recipeDetailIngredients`)
- A short **description** in English (for the ARB `@key` block)

Report the list to the user before proceeding (key → original string), then continue.

### 2A-4. Add keys to ALL ARB files

For each hardcoded string found:

**In `app_it.arb` (template):**
```json
"myKey": "Stringa originale",
"@myKey": {
  "description": "Short description in English"
}
```

**In every other ARB file** (e.g. `app_en.arb`): add the same key with the translated value for that language. If you are not confident about the translation, add the Italian value as a placeholder and append a `// TODO: translate` comment in the description — do not leave keys missing.

> **Rule**: every key must exist in every ARB file. A missing key in any language will break the build.

### 2A-5. Replace hardcoded strings in the Dart file

For each string replaced, use the `AppLocale.getLabels(context)` shorthand:

```dart
// Before
title: 'Ricette popolari',

// After
title: AppLocale.getLabels(context).homeSectionPopular,
```

If the widget is inside a `const` constructor, the `const` keyword must be removed from the ancestor that contains the localised call (since `AppLocale.getLabels(context)` is not a compile-time constant).

### 2A-6. Run codegen

After all ARB edits, run:
```bash
flutter gen-l10n
```

> **IMPORTANT**: use `flutter gen-l10n` — NOT `dart run build_runner build -d`.
> `build_runner` regenerates `*.g.dart` files (Riverpod/json_serializable) and does **not** touch localizations.

Then run `flutter analyze --no-pub` and fix any issues before reporting.

---

## Step 2B — Localise the entire project

Apply the same process as **Step 2A** but across all `.dart` files under `lib/screens/`, `lib/widgets/`, and `lib/layouts/`.

Proceed file by file. For each file:
1. Scan for hardcoded strings
2. Derive keys scoped to the feature (e.g. `formLabelEmail`, `profileTitle`)
3. Add to all ARB files
4. Replace in the Dart file

After all files are processed, run `flutter gen-l10n` and `flutter analyze --no-pub`.

---

## Step 2C — Add a new language

### 2C-1. Ask for the language

Ask the user:
- Which language? (provide the BCP 47 locale code, e.g. `fr`, `de`, `es`)

### 2C-2. Read the template ARB

Read `lib/l10n/app_it.arb` (the template). Collect every key and its `@key` description block.

### 2C-3. Create the new ARB file

Create `lib/l10n/app_<locale>.arb` with:
- `"@@locale": "<locale>"`
- Every key from the template, translated to the target language
- The same `@key` description blocks (descriptions stay in English)

If you are not confident about a translation, use the Italian value as a placeholder and note it in the description as `"// TODO: translate"`.

### 2C-4. Register the locale in `AppLocale`

Add the new `Locale('<locale>')` to the `supportedLocales` list in `lib/helpers/app_locale.dart`:

```dart
static const supportedLocales = [
  Locale('it'),
  Locale('en'),
  Locale('fr'), // ← new
];
```

### 2C-5. Run codegen

```bash
flutter gen-l10n
```

> **IMPORTANT**: use `flutter gen-l10n` — NOT `dart run build_runner build -d`.
> `build_runner` regenerates `*.g.dart` files (Riverpod/json_serializable) and does **not** touch localizations.

Then run `flutter analyze --no-pub` and fix any issues.

---

## Step 3 — Final report

Provide a concise report in Italian with:
- Task performed (localise screen / full project / new language)
- List of keys added to the ARB files
- Dart files modified
- Any strings skipped (with reason)
- Any TODOs left for manual translation
- Result of `flutter analyze`
