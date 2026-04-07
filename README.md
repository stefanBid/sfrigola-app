<div align="center">
  <div style="background: white; padding: 20px; border-radius: 12px; display: inline-block;">
    <a href="https://ibb.co/wH6MzNQ"><img src="https://i.ibb.co/22Kgk7M/logo.png" alt="logo" border="0" width="200"></a>
  </div>

  # Sfrigola

  ![Version](https://img.shields.io/badge/version-1.0.0-blue)
  [![Flutter](https://img.shields.io/badge/flutter-%3E%3D3.11.0-02569B?logo=flutter)](https://flutter.dev)
  ![Dart](https://img.shields.io/badge/dart-%5E3.11.3-0175C2?logo=dart)
  ![License](https://img.shields.io/badge/license-MIT-green)

  **The digital recipe book for everyday home cooking.**

  Quick and easy recipes for busy days, and more elaborate ones for when you want to challenge yourself and grow as a home chef apprentice.

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
10. [Repository & Data Layer](#10-repository--data-layer)
11. [Scripts](#11-scripts)
12. [AI Tooling — Prompts & Instructions](#12-ai-tooling--prompts--instructions)
13. [Deployment](#13-deployment)
14. [Versioning & Git Tags](#14-versioning--git-tags)
15. [Dependencies](#15-dependencies)

---

## 1. Overview

Sfrigola is a mobile app for home cooks of all skill levels. It offers quick and easy recipes for busy days and more elaborate ones for when you want to challenge yourself in the kitchen. Users can browse the recipe catalogue, discover new dishes, and grow their cooking skills one recipe at a time.

The app is built on a solid Flutter foundation with an opinionated design system, type-safe routing, reusable UI components, and pre-configured AI tooling — so development stays focused on features rather than scaffolding.

**Target audience:** Home cooks looking for a warm, food-oriented digital cookbook — from beginners to aspiring home chefs.

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

This section shows the full annotated directory tree of the project. Each top-level folder has a single responsibility.

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
    copilot-instructions.md          ← global Copilot rules
    instructions/                    ← scoped instruction files (loaded per file type)
      design-system.instructions.md
      helpers.instructions.md
      routing.instructions.md
      screens.instructions.md
      widgets.instructions.md
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
    helpers/              ← design system tokens and utilities
      app_colors.dart     ← adaptive colour palette
      app_design.dart     ← spacing, border radius, padding tokens
      app_locale.dart     ← localisation config and labels shorthand (AppLocale)
      app_router.dart     ← type-safe navigation layer (AppRouter)
      app_theme.dart      ← ThemeData configuration
      app_typography.dart ← text style scale
      app_validation.dart ← static form validators
      app_logger.dart     ← debug-only logger (stripped in release)
    l10n/                 ← localisation
      app_it.arb          ← Italian strings (template / only locale)
      app_localizations.dart     ← generated — do not edit manually
      app_localizations_it.dart  ← generated — do not edit manually
    layouts/              ← reusable page-level layout scaffolds
      app_layout.dart     ← shell with bottom navigation bar
      app_bars/
        classic_app_bar.dart     ← gradient app bar with title and actions
        transparent_app_bar.dart ← transparent overlay app bar
      body/
        standard_page_layout.dart ← column layout: app bar + scrollable body
        hero_page_layout.dart     ← full-bleed hero image + slide-up card body
    data/                 ← static datasets and seed data
      dummy_data.dart     ← auto-generated — run scripts/generate_dummy_data.py to refresh
    models/               ← data models
      json_serializable.dart   ← base interface: toJson()
      category.dart            ← Category model + CategoryColor enum
      meal.dart                ← Meal model + Complexity/Affordability enums
      repository_filter.dart   ← RepositoryFilter base (skip/take pagination)
    providers/            ← Riverpod providers (repository_providers.dart + feature providers)
    repositories/         ← repository layer (single point of contact with any data source)
      meal/
        meal_repository_model.dart  ← MealFilter + MealNotFoundException
        meal_repository.dart        ← abstract interface
        meal_repository_impl.dart   ← concrete implementation (dummy data → Dio)
      favorites/
        favorites_repository.dart        ← abstract interface
        favorites_repository_impl.dart   ← concrete implementation
    screens/              ← feature screens organised by folder
      home/               ← home screen (bottom nav tab)
      form/               ← form screen (bottom nav tab)
      profile/            ← profile screen (bottom nav tab)
      details/            ← detail screen (pushed with path parameter)
    widgets/              ← reusable UI components
      base_badge.dart              ← status badge
      base_button.dart             ← primary action button
      base_card.dart               ← image + text card
      base_form_field.dart         ← form-integrated text field
      base_icon_button.dart        ← icon-only button
      base_image_container.dart    ← network / asset image with fade
      base_input.dart              ← standalone text input
      base_box.dart               ← tappable surface container with ripple
      base_scaffold_messenger.dart ← themed SnackBar utility
      base_value_card.dart         ← metric display card (value + label)
      group-container/
        gc_list_view.dart ← null-safe ListView.builder wrapper
        gc_grid_view.dart ← GridView.count wrapper with dimensions
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

### `BaseBox`

Generic tappable container with surface background, border radius and ripple effect. Use it as a building block for clickable cards, rows, and any pressable surface that doesn't need an image.

| Prop | Type | Description |
|---|---|---|
| `child` | `Widget` | Required. Content inside the box. |
| `settings` | `BoxSettings` | Visual configuration. Defaults to `BoxSettings()`. |
| `onTap` | `VoidCallback?` | Tap handler. `null` → not tappable. |

**`BoxSettings` props:**

| Prop | Type | Default | Description |
|---|---|---|---|
| `color` | `Color?` | `AppColors.of(context).surface` | Background colour. `null` uses the surface token. |
| `borderRadius` | `BorderRadius` | `AppDesign.borderRadiusXs` | Corner radius. |
| `padding` | `EdgeInsetsGeometry` | `AppDesign.paddingSm` | Inner padding. |
| `margin` | `EdgeInsetsGeometry?` | `null` | Outer margin. |

```dart
// Default surface box
BaseBox(
  child: myWidget,
  onTap: () { ... },
)

// Custom colour and radius
BaseBox(
  child: myWidget,
  settings: BoxSettings(
    color: AppColors.of(context).background,
    borderRadius: AppDesign.borderRadiusMd,
    padding: AppDesign.paddingMd,
  ),
)
```

---

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

## 10. Repository & Data Layer

The repository layer is the **single point of contact** between the app and any data source — remote API, local DB, or seed data. Screens and providers never access data directly.

### Architecture

```
UI (Screens / Widgets)
       ↓
  Riverpod Providers   (lib/providers/)
       ↓
  Repository interface  (abstract interface class)
       ↓
  Repository impl       (*_repository_impl.dart)
       ↓
  Data source           (dummy_data.dart now → Dio + BE later)
```

### Domains

| Domain | Interface | Responsibility |
|---|---|---|
| `MealRepository` | `lib/repositories/meal/meal_repository.dart` | Categories, trending, recent, popular, meal detail |
| `FavoritesRepository` | `lib/repositories/favorites/favorites_repository.dart` | User favourites — add, remove, list, check |

### Filtering & Pagination — `MealFilter`

All list methods accept a `MealFilter` (never raw parameters). `MealFilter` extends the global `RepositoryFilter` base which carries `skip` and `take` for offset pagination.

```dart
// lib/models/repository_filter.dart
abstract class RepositoryFilter {
  const RepositoryFilter({this.skip = 0, this.take = 10});
  final int skip;
  final int take;
}

// lib/repositories/meal/meal_repository_model.dart
class MealFilter extends RepositoryFilter {
  const MealFilter({super.skip, super.take, this.categoryId, this.query = ''});
  final String? categoryId;  // null = no category filter
  final String query;        // '' = no text filter
}
```

### Switching to the real backend

The concrete implementations (`*_repository_impl.dart`) read from `dummy_data.dart` and are each marked with `// TODO: replace with <HTTP verb> <endpoint>`. When the backend is ready:

1. Replace the method body with a Dio call.
2. Authentication is sent automatically via a Dio interceptor — never pass tokens as parameters.
3. The interface, class signature, and all consumers remain unchanged.

### Error handling

Repositories throw typed exceptions (e.g. `MealNotFoundException`). The provider layer catches them and exposes `AsyncError` via Riverpod's `AsyncNotifier`. The UI handles them in `.when(error: ...)`. Repositories never return `null` or raw error strings.

### Dependency injection

Always consume repositories through Riverpod providers. Never instantiate a repository directly in a widget or screen.

```dart
// lib/providers/repository_providers.dart
@riverpod
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();

@riverpod
FavoritesRepository favoritesRepository(Ref ref) => FavoritesRepositoryImpl();
```

---

## 11. Scripts

Utility scripts live in `scripts/`. They automate data generation and other development tasks that would otherwise be manual.

### `scripts/generate_dummy_data.py`

Fetches meal data from [TheMealDB](https://www.themealdb.com) (free, no API key) and writes a valid `lib/data/dummy_data.dart` file. Every HTTP response is cached under `scripts/cache/` so subsequent runs are fast and offline-friendly.

```bash
# Prerequisites (once)
pip install -r scripts/requirements.txt

# Generate (uses cache — fast)
python scripts/generate_dummy_data.py

# Generate with more meals per category
python scripts/generate_dummy_data.py --meals-per-category 10

# Force fresh data from the server
python scripts/generate_dummy_data.py --clear-cache
```

> `lib/data/dummy_data.dart` is **auto-generated** — do not edit it manually. Always regenerate via the script.

---

## 12. AI Tooling — Prompts & Instructions

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
| `localize.prompt.md` | "Localizzami questa schermata" · "Localizza il progetto" · "Crea una nuova lingua" | `#localize.prompt.md` | Scans for hardcoded strings in a file or the full project; adds keys to all ARB files; replaces strings with `AppLocale.getLabels(context)`; supports adding new languages |
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
| `repository.instructions.md` | `**/repositories/**` | MealRepository / FavoritesRepository contracts, MealFilter, RepositoryFilter, DI pattern, error handling |

---

## 13. Deployment

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

## 14. Versioning & Git Tags

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

## 15. Dependencies

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
