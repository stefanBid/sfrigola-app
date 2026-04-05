<div align="center">
  <div style="background: white; padding: 20px; border-radius: 12px; display: inline-block;">
    <img src="https://stunning-confidence-0ce6b255c4.media.strapiapp.com/sb_template_flutter_logo_2c81964a6e.webp" alt="SB-Template Flutter Logo" width="200">
  </div>

  # SB-Template Flutter

  ![Version](https://img.shields.io/badge/version-2.0.0-blue)
  [![Flutter](https://img.shields.io/badge/flutter-%3E%3D3.11.0-02569B?logo=flutter)](https://flutter.dev)
  ![Dart](https://img.shields.io/badge/dart-%5E3.11.3-0175C2?logo=dart)
  ![License](https://img.shields.io/badge/license-MIT-green)

  **Stop wasting time on boilerplate. Start building features.**

  A Flutter starter template with an opinionated design system, type-safe routing, reusable UI components, and pre-configured AI tooling. Clone it, initialise it for your project, and start building features on day one.

</div>

---

## Table of Contents

1. [Overview](#1-overview)
2. [Getting Started](#2-getting-started)
3. [Project Structure](#3-project-structure)
4. [Design System](#4-design-system)
5. [Routing](#5-routing)
6. [Layouts](#6-layouts)
7. [Screens](#7-screens)
8. [Widgets](#8-widgets)
9. [Helpers & Validators](#9-helpers--validators)
10. [AI Tooling — Prompts & Instructions](#10-ai-tooling--prompts--instructions)
11. [Deployment](#11-deployment)
12. [Versioning & Git Tags](#12-versioning--git-tags)
13. [Dependencies](#13-dependencies)

---

## 1. Overview

SB-Template Flutter is designed to provide a solid and opinionated starting structure for building new mobile applications. It ships with a pre-configured design system, type-safe routing, reusable UI components, helpers, and layouts so that developers can focus on building features rather than scaffolding.

The template is meant to be cloned and initialised for a specific project (via the `init-project` prompt), progressively replacing placeholder screens and components with real ones while keeping the underlying conventions and tooling intact.

**Target audience:** Flutter developers who want a clean, consistent foundation without bikeshedding on folder structure, naming conventions, or design tokens.

---

## 2. Getting Started

### Prerequisites

- **Flutter SDK** ≥ 3.11.0
- **Dart SDK** ^3.11.3
- **Xcode** (for iOS development)
- **Android Studio** / **Android SDK** (for Android development)

### Installation

**Option 1: Use as GitHub Template** (Recommended)

1. Click **"Use this template"** on GitHub
2. Clone your new repository:

```bash
git clone https://github.com/your-username/your-project.git
cd your-project
```

**Option 2: Clone directly**

```bash
git clone https://github.com/stefanoBid/sb-flutter-template.git my-project
cd my-project
rm -rf .git && git init
```

### Project Initialisation

After cloning, run the `init-project` prompt in Copilot Agent mode (see [AI Tooling](#10-ai-tooling--prompts--instructions)) to rename the project, update all config files, and reset the version to `1.0.0+1`.

Then install dependencies and run the app:

```bash
flutter pub get
flutter run
```

### Available Commands

| Command | Description |
|---|---|
| `flutter run` | Run on connected device/emulator |
| `flutter run -d ios` | Run on iOS simulator |
| `flutter run -d android` | Run on Android emulator |
| `flutter build ipa --release` | Build iOS IPA |
| `flutter build appbundle --release` | Build Android App Bundle |
| `flutter analyze` | Analyse code for issues |
| `cider bump patch` | Bump patch version (1.0.0 → 1.0.1) |
| `cider bump minor` | Bump minor version (1.0.0 → 1.1.0) |
| `cider bump major` | Bump major version (1.0.0 → 2.0.0) |
| `cider version X.Y.Z` | Set a specific version |

---

## 3. Project Structure

This section shows the annotated directory tree of `lib/`. The project follows a feature-agnostic structure where each top-level folder has a single responsibility.

```
lib/
├── main.dart                        # App entry point
├── router.dart                      # GoRouter configuration (appRouter instance)
│
├── helpers/                         # Design system tokens and utilities
│   ├── app_colors.dart              # Adaptive colour palette
│   ├── app_design.dart              # Spacing, border radius, padding tokens
│   ├── app_router.dart              # Type-safe navigation layer (AppRouter)
│   ├── app_theme.dart               # ThemeData configuration
│   ├── app_typography.dart          # Text style scale
│   ├── app_validation.dart          # Static form validators
│   └── app_logger.dart              # Debug-only logger (stripped in release)
│
├── layouts/                         # Reusable page-level layout scaffolds
│   ├── app_layout.dart              # Shell with bottom navigation bar
│   ├── app_bars/
│   │   ├── classic_app_bar.dart     # Gradient app bar with title and actions
│   │   └── transparent_app_bar.dart # Transparent overlay app bar
│   └── body/
│       ├── standard_page_layout.dart # Column layout: app bar + scrollable body
│       └── hero_page_layout.dart    # Full-bleed hero image + slide-up card body
│
├── models/                          # Data models
│   └── json_serializable.dart       # Base JSON serialization helpers
│
├── screens/                         # Feature screens
│   ├── home/                        # Home screen (bottom nav tab)
│   ├── form/                        # Form screen (bottom nav tab)
│   ├── profile/                     # Profile screen (bottom nav tab)
│   └── details/                     # Detail screen (pushed with path parameter)
│
├── services/                        # Business logic and API services
│
└── widgets/                         # Reusable UI components
    ├── base_badge.dart              # Status badge
    ├── base_button.dart             # Primary action button
    ├── base_card.dart               # Image + text card
    ├── base_form_field.dart         # Form-integrated text field
    ├── base_icon_button.dart        # Icon-only button
    ├── base_image_container.dart    # Network / asset image with fade
    ├── base_input.dart              # Standalone text input
    ├── base_scaffold_messenger.dart # Themed SnackBar utility
    ├── base_value_card.dart         # Metric display card (value + label)
    └── group-container/
        ├── gc_list_view.dart        # Null-safe ListView.builder wrapper
        └── gc_grid_view.dart        # GridView.count wrapper with dimensions
```

---

## 4. Design System

The design system is entirely contained in `lib/helpers/` and provides a single source of truth for colours, typography, spacing and border radius. **Never use hardcoded values** — always reference these helpers.

### Colours — `AppColors`

`AppColors` is an adaptive class: instantiate it with `AppColors.of(context)` to get colours that automatically switch between light and dark mode.

```dart
final colors = AppColors.of(context);

colors.background   // page background
colors.surface      // card / input background
colors.text         // primary text
colors.muted        // secondary / disabled text
colors.bottomBar    // bottom navigation bar background
```

Static constants (non-adaptive, use directly):

| Token | Value | Usage |
|---|---|---|
| `AppColors.primary` | `#60C9F8` | Brand colour, active states |
| `AppColors.secondary` | `#0A599C` | Dark brand, dark-mode accents |
| `AppColors.error` | `#B00020` | Validation errors |
| `AppColors.success` | `#10B981` | Success states |
| `AppColors.warning` | `#F59E0B` | Warning states |

### Typography — `AppTypography`

Instantiate with `AppTypography.of(context)`. All styles inherit the adaptive text colour from `AppColors`.

| Style | Size | Weight | Usage |
|---|---|---|---|
| `heading1` | 28px | Bold | Main screen titles |
| `heading2` | 22px | Bold | Section titles |
| `heading3` | 18px | SemiBold | Subsection titles |
| `heading4` | 16px | SemiBold | Card titles, list item titles |
| `body` | 16px | Regular | Body text, paragraphs |
| `bodyMedium` | 14px | Regular | Inputs, dense UI |
| `bodySecondary` | 16px | Regular | Secondary / muted text |
| `caption` | 12px | Regular | Labels, captions |
| `small` | 11px | Regular | Badges, tiny labels |

```dart
Text('Welcome', style: AppTypography.of(context).heading1)
Text('Details', style: AppTypography.of(context).bodySecondary)
```

### Spacing & Radius — `AppDesign`

All tokens are `static const` — use them directly without instantiation.

**Border radius:**

| Token | Radius | Usage |
|---|---|---|
| `AppDesign.borderRadiusXXs` | 6px | Small chips, tight UI |
| `AppDesign.borderRadiusXs` | 10px | Inputs, buttons, small cards |
| `AppDesign.borderRadiusSm` | 20px | Medium cards |
| `AppDesign.borderRadiusMd` | 32px | Large cards, image containers |
| `AppDesign.borderRadiusLg` | 48px | Full pill, bottom sheets |

Top-only and bottom-only variants follow the same suffix pattern (e.g. `borderRadiusTopSm`, `borderRadiusBottomMd`).

**Padding presets:**

| Token | Description |
|---|---|
| `AppDesign.paddingXs/Sm/Md/Lg/Xl` | Uniform padding on all sides |
| `AppDesign.paddingSymmetricSm/Md/Lg` | Horizontal > vertical |
| `AppDesign.paddingHorizontalSm/Md/Lg` | Horizontal only |
| `AppDesign.paddingPage` | Standard page content padding |

### Icons — PhosphorIcons

This project uses [`phosphor_flutter`](https://pub.dev/packages/phosphor_flutter) for all icons. Never use Material `Icons.*`.

Available weight variants: `PhosphorIconsRegular`, `PhosphorIconsBold`, `PhosphorIconsFill`, `PhosphorIconsLight`, `PhosphorIconsThin`, `PhosphorIconsDuotone`.

```dart
Icon(PhosphorIconsBold.house)
Icon(PhosphorIconsFill.magnifyingGlass)
Icon(PhosphorIconsRegular.checkCircle)
```

---

## 5. Routing

Routing is powered by `go_router`. The template adds a **type-safe navigation layer** on top that prevents passing wrong parameters at compile time.

### Key files

| File | Role |
|---|---|
| `lib/router.dart` | `GoRouter` instance (`appRouter`) with all route registrations |
| `lib/helpers/app_router.dart` | Type-safe `AppRouter` class — the only place consuming code should touch |

### `AppRouter` API

Never call `context.go()` directly in your screens. Use `AppRouter` instead:

```dart
// Navigate to a route with no parameters
AppRouter.goTo(context, AppRouter.home);
AppRouter.goTo(context, AppRouter.forms);
AppRouter.goTo(context, AppRouter.profile);

// Push a detail route with a typed path parameter
AppRouter.goDeep(context, AppRouter.details, params: DetailParams(detailId: '42'));

// Go back (pops if possible, otherwise navigates home)
AppRouter.goBack(context);
```

### Defined routes

| Constant | Path | Parameters |
|---|---|---|
| `AppRouter.home` | `/home` | none |
| `AppRouter.forms` | `/form` | none |
| `AppRouter.profile` | `/profile` | none |
| `AppRouter.details` | `/details/:detailId` | `DetailParams(detailId)` |

### Adding a new route

**Step 1 — Define the params class** (skip if no parameters are needed):

```dart
class RecipeParams extends GenericRouteParams {
  final String recipeId;
  const RecipeParams({required this.recipeId});

  @override
  Map<String, String> toPathParams() => {'recipeId': recipeId};
}
```

**Step 2 — Add the constant in `AppRouter`** (`lib/helpers/app_router.dart`):

```dart
static const recipe = AppTypedRoute<RecipeParams>('/recipe/:recipeId');
```

**Step 3 — Register the `GoRoute`** in `lib/router.dart`:

```dart
GoRoute(
  path: '/recipe/:recipeId',
  pageBuilder: (context, state) {
    final recipeId = state.pathParameters['recipeId']!;
    return CustomTransitionPage(
      key: state.pageKey,
      child: RecipeScreen(recipeId: recipeId),
      transitionsBuilder: _customTransitionBuilder,
      transitionDuration: const Duration(milliseconds: 150),
    );
  },
),
```

### Transitions

The default transition is a fade (`FadeTransition`) defined by `_customTransitionBuilder` in `router.dart`. Bottom-nav tab routes use `NoTransitionPage` for an instant switch. Detail routes use the custom fade transition.

---

## 6. Layouts

Layouts are reusable page-level scaffolds in `lib/layouts/`. A screen should compose one layout rather than building its own `Scaffold` structure.

### `AppLayout`

The root shell used by `GoRouter`'s `ShellRoute`. Renders the bottom navigation bar with three tabs (Home, Forms, Profile). Pass `withBottomNav: false` for full-screen flows like detail screens.

### `StandardPageLayout`

A column layout with an optional app bar slot and a body that fills the remaining space.

| Prop | Type | Description |
|---|---|---|
| `body` | `Widget` | Required. The main content area. |
| `appBar` | `Widget?` | Optional app bar widget placed at the top. |
| `hasPadding` | `bool` | Apply `AppDesign.paddingPage` to body. Defaults to `true`. |

### `HeroPageLayout`

Full-bleed hero image at the top with a rounded card that slides up over it. Suited for detail screens.

| Prop | Type | Description |
|---|---|---|
| `imageUrl` | `String` | Required. URL of the hero image. |
| `body` | `Widget` | Required. Content placed inside the scrollable card. |
| `imageHeight` | `double` | Hero image height. Defaults to `280`. |
| `onBack` | `VoidCallback?` | Custom back button handler. |

### `ClassicAppBar`

A gradient app bar (primary → background) with title, optional leading widget, optional actions and an optional `bottomContent` slot for search bars or tabs.

| Prop | Type | Description |
|---|---|---|
| `title` | `String?` | App bar title. |
| `titleStyle` | `TextStyle?` | Override default heading2 style. |
| `leading` | `Widget?` | Widget shown before the title. |
| `actions` | `List<Widget>?` | Widgets shown after the title. |
| `bottomContent` | `Widget?` | Content below the title row. |

### `TransparentAppBar`

An overlay app bar for use on top of hero images or full-bleed backgrounds. Fully transparent background.

---

## 7. Screens

Screens live in `lib/screens/`, organised by feature folder. Each folder should contain the screen file and, optionally, feature-specific widgets.

### Conventions

- One screen per file. File name: `[feature]_screen.dart`, class name: `[Feature]Screen`.
- Screens are `StatelessWidget` unless local state is strictly necessary.
- All layout is delegated to a layout from `lib/layouts/` — screens do not build raw `Scaffold`s.
- Navigation is always performed via `AppRouter`.

### Available screens

| Screen | Path | Description |
|---|---|---|
| `HomeScreen` | `/home` | Main landing tab |
| `FormScreen` | `/form` | Form examples tab |
| `ProfileScreen` | `/profile` | Profile tab |
| `DetailsScreen` | `/details/:detailId` | Detail view pushed with a `detailId` parameter |

---

## 8. Widgets

All reusable widgets live in `lib/widgets/`. Widget names must describe **what the widget is**, not where it is used. All widgets use the design system tokens — never hardcoded values.

### `BaseButton`

Full-featured action button with variants, loading state and optional icon.

| Prop | Type | Description |
|---|---|---|
| `label` | `String?` | Button label text. |
| `icon` | `IconData?` | Optional icon (at least one of `label`/`icon` is required). |
| `onPressed` | `VoidCallback?` | Tap handler. `null` renders the button as disabled. |
| `type` | `BaseButtonType` | `filled` (default) or `outlined`. |
| `fullWidth` | `bool` | Expand to fill available width. Defaults to `false`. |
| `isLoading` | `bool` | Show loading spinner instead of content. Defaults to `false`. |
| `tooltip` | `String?` | Accessibility tooltip. |

```dart
BaseButton(label: 'Submit', onPressed: _submit, isLoading: _isLoading)
BaseButton(icon: PhosphorIconsBold.plus, type: BaseButtonType.outlined, onPressed: _add)
```

### `BaseIconButton`

Icon-only button with filled or outlined style.

| Prop | Type | Description |
|---|---|---|
| `icon` | `IconData` | Required. Icon to display. |
| `onPressed` | `VoidCallback?` | Tap handler. |
| `type` | `IconButtonType` | `filled` (default) or `outlined`. |
| `color` | `Color?` | Override icon and border colour. |
| `tooltip` | `String?` | Accessibility tooltip. |

### `BaseBadge`

Status or label badge with optional icon.

| Prop | Type | Description |
|---|---|---|
| `label` | `String?` | Badge text. |
| `icon` | `IconData?` | Optional leading icon (at least one of `label`/`icon` is required). |
| `style` | `BadgeStyle` | Styling configuration (see below). |

**`BadgeStyle` props:**

| Prop | Type | Description |
|---|---|---|
| `color` | `Color?` | Background (filled) or border (outlined) colour. |
| `foregroundColor` | `Color?` | Icon and text colour. |
| `size` | `BadgeSize` | `small` (default) or `normal`. |
| `variant` | `BadgeVariant` | `filled` (default) or `outlined`. |
| `borderRadius` | `BorderRadiusGeometry` | Defaults to `AppDesign.borderRadiusXXs`. |

```dart
BaseBadge(label: 'Active', style: BadgeStyle(color: AppColors.success))
BaseBadge(icon: PhosphorIconsRegular.star, style: BadgeStyle(variant: BadgeVariant.outlined))
```

### `BaseCard`

Image + text card for lists and grids.

| Prop | Type | Description |
|---|---|---|
| `title` | `String` | Required. Card title. |
| `content` | `String` | Required. Card subtitle / description. |
| `imageUrl` | `String` | Required. Network image URL. |
| `width` | `double` | Card width. Defaults to `220`. |
| `height` | `double` | Card height. Defaults to `220`. |
| `padding` | `EdgeInsetsGeometry` | Outer padding. Defaults to `EdgeInsets.zero`. |
| `onTap` | `VoidCallback?` | Tap handler. |

### `BaseFormField`

Form-integrated text field with label, validation and error display. Use inside a `Form` widget.

| Prop | Type | Description |
|---|---|---|
| `controller` | `TextEditingController` | Required. |
| `label` | `String?` | Label displayed above the field. |
| `hint` | `String?` | Placeholder text. |
| `prefixIcon` | `IconData?` | Leading icon. |
| `suffixIcon` | `Widget?` | Trailing widget (e.g. visibility toggle). |
| `obscureText` | `bool` | Mask text (password). Defaults to `false`. |
| `keyboardType` | `TextInputType?` | Input type. |
| `validator` | `String? Function(String?)?` | Validation function. |
| `autovalidateMode` | `AutovalidateMode` | Defaults to `AutovalidateMode.onUnfocus`. |
| `onChanged` | `ValueChanged<String>?` | Called on every keystroke. |
| `onFieldSubmitted` | `ValueChanged<String>?` | Called on keyboard submit. |

### `BaseInput`

Standalone text field without form integration. Use for search bars or filters.

| Prop | Type | Description |
|---|---|---|
| `controller` | `TextEditingController` | Required. |
| `hint` | `String?` | Placeholder text. |
| `prefixIcon` | `Widget?` | Leading widget. |
| `suffixIcon` | `Widget?` | Trailing widget. |
| `onChanged` | `ValueChanged<String>?` | Called on every keystroke. |
| `fillColor` | `Color?` | Background colour override. |

### `BaseImageContainer`

Network or asset image with fade-in animation and optional darkening filter.

| Prop | Type | Description |
|---|---|---|
| `imageUrl` | `String` | Required. URL or asset path. |
| `type` | `ImageType` | `network` (default) or `asset`. |
| `filter` | `ImageFilter` | `none` (default) or `darken`. |
| `fit` | `ImageFit` | `cover` (default) or `contain`. |
| `width` | `double?` | Container width. |
| `height` | `double?` | Container height. |
| `borderRadius` | `BorderRadius` | Defaults to `AppDesign.borderRadiusMd`. |
| `fadeDuration` | `Duration` | Fade-in duration. Defaults to 300ms. |

### `BaseValueCard`

Compact metric display showing a value and a label.

| Prop | Type | Description |
|---|---|---|
| `value` | `String` | Required. Main metric text (large). |
| `label` | `String` | Required. Description below the value. |

### `BaseScaffoldMessenger`

Static utility that shows a themed SnackBar anchored to the bottom of the screen.

```dart
BaseScaffoldMessenger.show(
  context,
  message: 'Saved successfully',
  type: SnackBarType.success,
);
```

| Type | Colour |
|---|---|
| `SnackBarType.success` | `AppColors.success` |
| `SnackBarType.error` | `AppColors.error` |
| `SnackBarType.warning` | `AppColors.warning` |
| `SnackBarType.info` | Primary (adaptive) |

### `GcListView` (group-container)

A null-safe `ListView.builder` wrapper. Items returned as `null` from `itemBuilder` are silently skipped.

| Prop | Type | Description |
|---|---|---|
| `itemBuilder` | `Widget? Function(BuildContext, int)` | Required. |
| `itemCount` | `int` | Required. Negative values are treated as 0. |
| `scrollDirection` | `Axis` | Defaults to `Axis.vertical`. |
| `padding` | `EdgeInsetsGeometry?` | Defaults to `EdgeInsets.zero`. |

### `GcGridView` (group-container)

A `GridView.count` wrapper with a `GridDimensions` configuration object.

| Prop | Type | Description |
|---|---|---|
| `children` | `List<Widget>` | Required. Grid items. |
| `dimensions` | `GridDimensions` | Grid configuration. Defaults to `GridDimensions()`. |

**`GridDimensions` defaults:** `crossAxisCount: 2`, `childAspectRatio: 3/2`, `crossAxisSpacing` and `mainAxisSpacing` use `AppDesign.gapItemMd`.

---

## 9. Helpers & Validators

All helpers live in `lib/helpers/` as flat files. The set of files in this folder is fixed — do not rename or reorganise them.

### `app_colors.dart`

Exports `AppColors`. See [Design System — Colours](#colours--appcolors).

### `app_design.dart`

Exports `AppDesign`. See [Design System — Spacing & Radius](#spacing--radius--appdesign).

### `app_typography.dart`

Exports `AppTypography`. See [Design System — Typography](#typography--apptypography).

### `app_theme.dart`

Exports the `ThemeData` used in `MaterialApp`. Edit this file to change the font family (uses `google_fonts`) or override Material component themes.

### `app_router.dart`

Exports `AppRouter`, `AppTypedRoute<P>`, `GenericRouteParams`, `NoParams`, and built-in params classes (`DetailParams`). See [Routing](#5-routing).

### `app_validation.dart`

Exports `AppValidation` — a collection of static validators for use inside `TextFormField` / `BaseFormField` validators.

Chain validators with `??` — the first failure wins:

```dart
validator: (v) => AppValidation.notEmpty(v) ?? AppValidation.email(v),
```

| Method | Description |
|---|---|
| `notEmpty(v)` | Field must not be null or empty. |
| `email(v)` | Must be a valid email address. |
| `minLength(v, min)` | Minimum character length. |
| `maxLength(v, max)` | Maximum character length. |
| `match(v, other)` | Both values must be equal (e.g. confirm password). |
| `numeric(v)` | Must contain only digits. |
| `strongPassword(v)` | Must contain uppercase, lowercase and a digit. |

All methods accept an optional `message` parameter to override the default error string.

### `app_logger.dart`

Exports `AppLogger` — a debug-only logger gated behind `kDebugMode`. All output is automatically stripped in release and profile builds. **Never use `print()` directly** — always use `AppLogger`.

```dart
AppLogger.debug('User loaded', tag: 'HomeScreen');
AppLogger.warn('Token is about to expire');
AppLogger.error('Failed to fetch', error: e, stackTrace: st);
```

| Method | Level | When to use |
|---|---|---|
| `AppLogger.debug(message, {tag})` | `[D]` | General flow information |
| `AppLogger.warn(message, {tag})` | `[W]` | Non-critical anomalies |
| `AppLogger.error(message, {tag, error, stackTrace})` | `[E]` | Exceptions and failures |

The optional `tag` parameter (e.g. `tag: 'AuthService'`) prefixes the output for easier filtering in the console.

---

## 10. AI Tooling — Prompts & Instructions

This repository ships with pre-configured [GitHub Copilot](https://github.com/features/copilot) context that makes the AI assistant aware of the project's conventions, design system and domain. All configuration lives under `.github/` and is versioned alongside the code.

### How GitHub Copilot is configured

| File / folder | Purpose |
|---|---|
| `.github/copilot-instructions.md` | Global rules: app context, response language, stack, naming conventions |
| `.github/instructions/*.instructions.md` | Scoped rules loaded automatically per file type (e.g. only for `**/*.dart` files) |
| `.github/prompts/*.prompt.md` | Reusable Agent-mode workflows triggered by a phrase or `#filename` syntax |

### Available prompts

| Prompt file | Trigger phrases | Direct invocation | What it does |
|---|---|---|---|
| `init-project.prompt.md` | "Inizializziamo il progetto" · "Inizializza il progetto" · "Reset del progetto" | `#init-project.prompt.md` | Collects project name and context; renames the app across all config files; resets version to `1.0.0+1`; audits and updates instruction files |
| `update-docs.prompt.md` | "Aggiorna la documentazione" | `#update-docs.prompt.md` | Compares README with the actual codebase and rewrites it as a structured documentation book |
| `check-dependencies.prompt.md` | "Verifichiamo aggiornamenti del progetto" | `#check-dependencies.prompt.md` | Runs `flutter pub outdated`, auto-updates safe (minor/patch) packages, lists major bumps for review |
| `check-lint.prompt.md` | "Check del progetto", "il progetto è pulito?" | `#check-lint.prompt.md` | Runs `dart fix`, `dart format` and `flutter analyze`; auto-fixes warnings, reports errors for manual review |
| `bump-version.prompt.md` | "Aggiornami il progetto alla versione X.Y.Z" | `#bump-version.prompt.md` | Detects changes via git, shows a CHANGELOG draft for approval, then uses **cider** to bump the version and release |

### How to run a prompt

**Option A — Trigger phrase**

1. Open the **Copilot Chat** panel in VS Code (`⌃⌘I` / `Ctrl+Alt+I`)
2. Switch to **Agent mode** using the mode selector at the bottom of the chat input
3. Type one of the trigger phrases from the table above — the agent will load and follow the prompt automatically

**Option B — Direct invocation**

1. Open **Copilot Chat** in **Agent mode**
2. In the chat input, type `#` followed by the prompt filename (e.g. `#check-dependencies.prompt.md`) and select it from the picker
3. Send the message — the agent will execute the prompt immediately, regardless of the phrasing used

> **Note:** All prompts require **Agent mode**. They will not work in Ask or Chat mode.

### Instruction files

| File | Applies to | Governs |
|---|---|---|
| `design-system.instructions.md` | `**/*.dart` | AppColors, AppTypography, AppDesign tokens, PhosphorIcons API, widget checklist |
| `screens.instructions.md` | `**/screens/**` | Screen structure, layouts, app bars, code organisation rules |
| `widgets.instructions.md` | `**/widgets/**` | Widget placement rules and widget API reference |
| `routing.instructions.md` | `**/*router*` | AppRouter API, transitions, new-route workflow |
| `helpers.instructions.md` | `**/helpers/**` | Fixed helper filenames, AppValidation validators and chaining patterns |

---

## 11. Deployment

### iOS

#### Test distribution (TestFlight)

1. Bump version/build with the `bump-version` prompt
2. Build the release IPA: `flutter build ipa --release`
3. Open `build/ios/archive/Runner.xcarchive` in Xcode Organizer
4. Product → Archive → Distribute App → App Store Connect → TestFlight
5. Invite internal or external testers from [App Store Connect](https://appstoreconnect.apple.com)

#### Production release (App Store)

1. Ensure version and build number are correct
2. `flutter build ipa --release`
3. Open `build/ios/archive/Runner.xcarchive` in Xcode Organizer → Distribute → App Store Connect
4. Complete metadata, screenshots and review information on App Store Connect
5. Submit for review

### Android

#### Test distribution (Internal Testing / Firebase App Distribution)

1. Bump version/build with the `bump-version` prompt
2. `flutter build appbundle --release` (preferred) or `flutter build apk --release`
3. **Google Play** → Internal Testing track → upload `.aab`
4. **Firebase App Distribution** (alternative) → upload `.apk` and invite testers

#### Production release (Google Play)

1. Ensure `versionName` and `versionCode` are correct in `pubspec.yaml`
2. Configure signing: create `android/key.properties` and add the keystore block to `android/app/build.gradle`
3. `flutter build appbundle --release`
4. Upload to [Google Play Console](https://play.google.com/console) → Production track
5. Complete store listing, content rating and submit for review

#### Signing & secrets

- Never commit keystore files or `key.properties` to version control
- Add them to `.gitignore` before the first commit
- Store secrets in environment variables or a secrets manager (e.g. GitHub Secrets for CI)

---

## 12. Versioning & Git Tags

The project uses [**cider**](https://pub.dev/packages/cider) to manage the version in `pubspec.yaml` and maintains a `CHANGELOG.md` following the [Keep a Changelog](https://keepachangelog.com) convention. Every production release should be tagged in Git so that the history stays navigable and CI/CD pipelines can anchor artifacts to a precise commit.

### Version format

Versions follow **Semantic Versioning** (`MAJOR.MINOR.PATCH`) with a build number appended after `+` (e.g. `1.2.0+7`). The build number is incremented automatically by `cider bump` and is used by the app stores.

### Workflow — from bump to tag

```bash
# 1. Update the version (choose the appropriate bump type)
cider bump patch   # 1.0.0 → 1.0.1
cider bump minor   # 1.0.0 → 1.1.0
cider bump major   # 1.0.0 → 2.0.0
# Or set an exact version:
cider version 2.0.0

# 2. Stage and commit the version change
git add pubspec.yaml CHANGELOG.md
git commit -m "chore: bump version to $(cider version)"

# 3. Create an annotated tag on main
git tag -a "v$(cider version)" -m "Release v$(cider version)"

# 4. Push the commit and the tag
git push origin main
git push origin "v$(cider version)"
```

> **Always use annotated tags** (`-a` flag) rather than lightweight ones. Annotated tags store the tagger, date and message — they are first-class objects in Git and are picked up correctly by GitHub Releases and most CI/CD systems.

### Tag naming convention

| Pattern | Example | When to use |
|---|---|---|
| `vMAJOR.MINOR.PATCH` | `v1.2.0` | Every production release |
| `vMAJOR.MINOR.PATCH-beta.N` | `v2.0.0-beta.1` | Pre-release / beta builds |

### Listing and deleting tags

```bash
# List all tags (sorted by version)
git tag --sort=-version:refname

# Show details of a specific tag
git show v1.2.0

# Delete a tag locally (e.g. if created by mistake)
git tag -d v1.2.0

# Delete the tag from the remote as well
git push origin --delete v1.2.0
```

### Using the `bump-version` prompt

The `bump-version` Copilot Agent prompt automates steps 1–4: it detects changes via `git`, generates a CHANGELOG draft for your approval, bumps the version with `cider`, commits, tags and pushes. See [AI Tooling](#10-ai-tooling--prompts--instructions) for usage details.

---

## 13. Dependencies

| Package | Version | Purpose |
|---|---|---|
| `go_router` | ^17.1.0 | Declarative routing with deep linking |
| `google_fonts` | ^8.0.2 | Font loading (Lato used by default) |
| `cached_network_image` | ^3.4.1 | Network image loading with cache and fade |
| `phosphor_flutter` | ^2.1.0 | Icon library |
| `image_picker` | ^1.2.1 | Camera and gallery access |
| `package_info_plus` | ^9.0.1 | App version and build info at runtime |
| `intl` | ^0.20.2 | Internationalisation utilities |
| `uuid` | ^4.5.2 | Unique ID generation |
| `cupertino_icons` | ^1.0.9 | iOS-style icon assets |
| `cider` *(dev)* | ^0.2.10 | CLI version management |
| `flutter_lints` *(dev)* | ^6.0.0 | Flutter team's recommended lints |

---

<div align="center">

Built with ❤️ by **Stefano Biddau**

[stefanobiddau.com](https://stefanobiddau.com) · [@stefanoBid](https://github.com/stefanoBid)

</div>
