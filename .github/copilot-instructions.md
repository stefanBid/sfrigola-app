# Copilot Instructions — sb_template_flutter

## App context

This is a Flutter template app designed to provide a solid and opinionated starting structure for building new mobile applications. It comes with a pre-configured design system, routing setup, reusable widgets, helpers and project organisation so that developers can focus on building features rather than scaffolding. The template is meant to be cloned and initialised for a specific project, progressively replacing placeholder screens and components with real ones while keeping the underlying conventions and tooling intact.

Use this context to give suggestions — UI, UX, architectural or otherwise — that are consistent with a general-purpose, well-structured Flutter starter template.

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
- **provider / riverpod** for state management (to be evaluated for future features)

---

## Instruction files (loaded contextually)

| File | `applyTo` | Content |
|---|---|---|
| `design-system.instructions.md` | `**/*.dart` | AppColors, AppTypography, AppDesign tokens, PhosphorIcons API, widget checklist |
| `routing.instructions.md` | `**/*router*` | AppRouter API, transitions, new-route workflow (3 steps) |
| `screens.instructions.md` | `**/screens/**` | Screen structure, layouts, app bars, code organisation rules |
| `widgets.instructions.md` | `**/widgets/**` | Widget placement rules, BaseCard/BaseFormField/BaseButton/GcListView API |
| `helpers.instructions.md` | `**/helpers/**` | Fixed helper filenames, AppValidation validators and chaining patterns |

> **Keep instructions in sync**: every time a new widget, helper, or token is added — or an existing one is changed — update the corresponding instruction file immediately. These files are the source of truth for code generation context.

---

## Project structure

```
lib/
  main.dart
  router.dart
  helpers/        ← design system tokens and utilities
  layouts/        ← reusable page layouts
  models/         ← data models
  screens/        ← screens organised by feature
  services/       ← business logic and API
  widgets/        ← reusable UI components
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
- Imports must be grouped by origin, each group preceded by a comment, with a blank line between groups. Always use relative paths. Order:
  ```dart
  import 'package:flutter/material.dart';
  import 'package:phosphor_flutter/phosphor_flutter.dart';
  // ... other third-party packages

  // Project Helpers
  import '../../helpers/app_colors.dart';

  // Project Layouts
  import '../../layouts/body/standard_page_layout.dart';

  // Project Models
  import '../../models/recipe.dart';

  // Project Screens (if needed)
  import '../recipe-detail/recipe_detail_screen.dart';

  // Project Services
  import '../../services/recipe_service.dart';

  // Project Widgets
  import '../../widgets/base_button.dart';
  ```
  Omit groups that are not needed. Never use absolute `package:` paths for project-internal files.
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
| Screen / page | `screens.instructions.md` |
| Widget (reusable component) | `widgets.instructions.md` |
| Helper / validator | `helpers.instructions.md` |

Read the relevant file with `read_file` before answering. Skip the question if the request clearly mentions an area (e.g. "new screen", "add a route", "a validator").
