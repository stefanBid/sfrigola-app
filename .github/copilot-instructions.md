# Copilot Instructions — sfrigola

## App context

Sfrigola is the digital recipe book designed for everyday home cooking — the real kind. It offers quick and easy recipes for busy days, and more elaborate ones for when you want to challenge yourself and grow as a home chef apprentice.

Use this context to give suggestions — UI, UX, architectural or otherwise — that are consistent with a recipe-focused mobile app aimed at home cooks of all skill levels.

---

## Identifier name: `Signore delle UI`

## Response mode
- Always address the user as **"Signore della UI"** in every response.
- Always reply in **Italian** in chat.

## Stack
- **Flutter** (Dart) — mobile app (iOS + Android)
- **go_router** for navigation
- **phosphor_flutter** for icons
- **google_fonts** (Lato) for typography
- **transparent_image** for network images with fade
- **hooks_riverpod** + **flutter_hooks** + **riverpod_annotation** for state management
- **Dio** for HTTP client (future — not yet installed)

---

## Instruction files (loaded contextually)

| File | `applyTo` | Content |
|---|---|---|
| `design-system.instructions.md` | `**/*.dart` | AppColors, AppTypography, AppDesign tokens, PhosphorIcons API, widget checklist |
| `routing.instructions.md` | `**/*router*` | AppRouter API, transitions, new-route workflow (3 steps) |
| `feature.instructions.md` | `**/features/**` | Feature structure, screen/widget/provider placement, layouts, app bars, code organisation |
| `widgets.instructions.md` | `**/widgets/**` | Widget placement rules, BaseCard/BaseFormField/BaseButton/GcListView API |
| `helpers.instructions.md` | `**/helpers/**` | Fixed helper filenames, AppValidation validators and chaining patterns |
| `repository.instructions.md` | `**/repositories/**` | MealRepository / FavoritesRepository contracts, MealFilter, mock rules, naming, DI pattern |
| `state-management.instructions.md` | `**/providers/**,**/features/**,**/widgets/**` | Riverpod provider types, `ref` usage rules, `AsyncValue` pattern, `keepAlive`, family, naming, checklist |

> **Keep instructions in sync**: every time a new widget, helper, or token is added — or an existing one is changed — update the corresponding instruction file immediately. These files are the source of truth for code generation context.

---

## Project structure

```
sfrigola-app/
  pubspec.yaml            ← dependencies, version, flutter config (generate: true)
  pubspec.lock            ← locked dependency versions (do not edit manually)
  l10n.yaml               ← flutter gen-l10n configuration (ARB dir, template, output)
  analysis_options.yaml   ← Dart linter rules
  CHANGELOG.md            ← Keep a Changelog format, managed with cider
  README.md               ← project documentation
  .gitignore
  assets/                 ← static assets (images, icons, fonts)
  android/                ← Android platform project
  ios/                    ← iOS platform project
  .github/
    copilot-instructions.md          ← global Copilot rules (this file)
    instructions/                    ← scoped instruction files (loaded per file type)
      design-system.instructions.md
      helpers.instructions.md
      repository.instructions.md
      routing.instructions.md
      feature.instructions.md
      widgets.instructions.md
      state-management.instructions.md
    prompts/                         ← reusable Agent-mode workflows
      init-project.prompt.md
      localize.prompt.md
      update-docs.prompt.md
      check-dependencies.prompt.md
      check-lint.prompt.md
      bump-version.prompt.md
  lib/
    main.dart             ← app entry point (MaterialApp.router + AppLocale + AppTheme)
    router.dart           ← GoRouter instance (appRouter) with all route registrations
    core/                 ← shared code used across features
      data/               ← auto-generated dummy data (do not edit manually)
      helpers/            ← design system tokens and utilities
      l10n/               ← ARB translation files + generated localizations
      layouts/            ← reusable page layouts
      models/             ← data models
        category.dart
        json_serializable.dart
        meal.dart
        repository_filter.dart   ← base RepositoryFilter (skip/take)
      providers/          ← app-wide Riverpod providers
      repositories/       ← repository layer
        meal/
          meal_repository_model.dart
          meal_repository.dart
          meal_repository_impl.dart
        favorites/
          favorites_repository.dart
          favorites_repository_impl.dart
      widgets/            ← reusable UI components (base_* + group-container/)
    features/             ← all product features
      feature-home/         ← home feed feature
        home_screen.dart
        providers/
        widgets/
      feature-meal-detail/  ← meal detail feature
        meal_details_screen.dart
        providers/
        widgets/
      feature-search/       ← search feature
        search_screen.dart
        providers/
        widgets/
      feature-profile/      ← user profile feature
        profile_screen.dart
      feature-form/         ← form demo feature
        form_screen.dart
```

---

## Global naming rules

| Element | Style | Example |
|---|---|---|
| Directory | kebab-case | `recipe-detail/`, `group-container/` |
| Dart file | snake_case + suffix | `recipe_detail_screen.dart` |
| Class/Widget | PascalCase | `RecipeDetailScreen` |

**Never** use camelCase or PascalCase for file or directory names.

**Widget naming — be generic**: the name must describe **what the widget is**, not where it is used. Bad: `base_name_input`, `base_stat_card`. Good: `base_input`, `base_value_card`. If a name only makes sense in one specific context, it is too specific — generalise it.

---

## Global code conventions

- All hardcoded strings and code comments must be in **English**
- Imports must be grouped by origin, each group preceded by a comment, with a blank line between groups. Always use absolute `package:sfrigola/` paths for project-internal files. Order:
  ```dart
  import 'package:flutter/material.dart';
  import 'package:phosphor_flutter/phosphor_flutter.dart';
  // ... other third-party packages

  // Project Helpers
  import 'package:sfrigola/core/helpers/app_colors.dart';

  // Project Layouts
  import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

  // Project Models
  import 'package:sfrigola/core/models/recipe.dart';

  // Project Features (if importing screens from another feature)
  import 'package:sfrigola/features/feature-recipe-detail/recipe_detail_screen.dart';

  // Project Repositories
  import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';
  import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
  import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';

  // Project Widgets
  import 'package:sfrigola/core/widgets/base_button.dart';
  ```
  Omit groups that are not needed. Never use relative paths for project-internal files.
- `const` wherever possible to optimise rebuilds. A constructor call **must** be `const` when: (1) the widget has a `const` constructor, and (2) all arguments are compile-time values (string/number literals, `static const` tokens, other `const` constructors). When the parent is already `const`, children drop the keyword — move `const` to the outermost eligible ancestor instead
- `StatelessWidget` preferred where there is no local state
- Never use hardcoded colours, font sizes, spacing or border radius — always use design system helpers
- Network images: always use `BaseImageContainer`
- Do not use `MediaQuery` for spacing that can be a design token
- Vertical `ListView`s nested inside other scrolls: `shrinkWrap: true` + `NeverScrollableScrollPhysics()` only if the list is short and static
- For horizontal lists nested inside vertical scrolls: use `SizedBox` with fixed height, never `shrinkWrap: true` on long lists

---

## Project initialisation — trigger phrase

When the user writes something like **"Inizializziamo il progetto"**, **"inizializza il progetto"**, **"reset del progetto"**, or any clearly equivalent phrase:

- **If in Agent mode**: follow the workflow defined in `.github/prompts/init-project.prompt.md` step by step.
- **If in Ask / Chat mode** (no file-system tools available): reply **only** with:
  > "Per eseguire l'inizializzazione del progetto devo essere in modalità **Agent**. Ri-lancia la richiesta in Agent mode."
  Then stop. Do not attempt the workflow.

---

## Context resolution — when to ask

If no file is open in the editor and the request is ambiguous (it is not clear which area it concerns), **before answering or generating code** ask the user a single question using `vscode_askQuestions` with these options:

| Option | Loads |
|---|---|
| Design system (colours, typography, spacing, icons) | `design-system.instructions.md` |
| Navigation / new route | `routing.instructions.md` |
| Screen / feature | `feature.instructions.md` |
| Widget (reusable component) | `widgets.instructions.md` |
| Helper / validator | `helpers.instructions.md` |
| Repository / data layer | `repository.instructions.md` |

Read the relevant file with `read_file` before answering. Skip the question if the request clearly mentions an area (e.g. "new screen", "add a route", "a validator").
