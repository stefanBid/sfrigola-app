---
applyTo: "**/features/**"
---

# Feature — Structure and conventions

## File placement

Each feature lives in its own kebab-case directory under `lib/features/`:

```
features/
  feature-recipe-detail/
    recipe_detail_screen.dart   ← main screen file
    providers/                  ← feature-scoped providers (if any)
    widgets/                    ← feature-specific widgets (if any)
      ingredient_chip.dart
```

- Parent directory: `lib/features/` (all features live here)
- Feature directory: **`feature-` + kebab-case** (`feature-recipe-detail/`)
- File: **snake_case** (`recipe_detail_screen.dart`)
- Class: **PascalCase** (`RecipeDetailScreen`)
- Create `widgets/` and `providers/` sub-directories as needed

---

## Available layouts

> **Rule — layouts always live in `core/`**: page layouts are architectural patterns (they define the *shape* of a screen, not its content). They always belong in `lib/core/layouts/` regardless of how many features currently use them. The "≤ 2 features → feature folder" rule applies only to UI widgets, never to page layouts.

### `StandardPageLayout`

Standard scrollable page with optional app bar. Import from `package:sfrigola/core/layouts/body/standard_page_layout.dart`.

```dart
StandardPageLayout(
  hasPadding: true,          // default true — applies AppDesign.paddingPage
  appBar: const ClassicAppBar(title: 'Title'),
  body: ...,
)
```

### `AppLayout`

Shell layout with bottom navigation bar. Used via `ShellRoute` — do not instantiate directly.

### `HeroPageLayout`

Detail page with a hero image occupying the top 35% of the screen and a slide-up content card below. Built-in back button via `TransparentAppBar`. Import from `package:sfrigola/core/layouts/body/hero_page_layout.dart`.

```dart
HeroPageLayout(
  imageUrl: meal.imageUrl,
  imageHeight: 280,       // optional, default 280
  onBack: () { ... },     // optional — defaults to AppRouter.goBack
  body: ...,
)
```

### `MessagePageLayout`

Centred message layout for error, empty and informational states. Import from `package:sfrigola/core/layouts/body/message_page_layout.dart`.

```dart
MessagePageLayout(
  message: 'No results found',
  icon: PhosphorIconsBold.cookingPot,   // optional — use AppDesign.iconSizeXxl internally
  type: MessagePageType.muted,          // standard | muted
  onRetry: () { ... },                  // optional — shows ghost+pill retry button
)
```

**Types:**
- `standard` — `heading4` text, full-weight icon. Use for invitations to act (e.g. search hint) and blocking states.
- `muted` — `bodySecondary` w600 text, muted icon. Use for empty states, no results, and non-blocking errors.

**Icon convention:**
- Generic error → `PhosphorIconsBold.warningCircle`
- No results from search → `PhosphorIconsBold.cookingPot`
- Search invitation (no query active) → `PhosphorIconsRegular.bowlFood`
- Empty category / feed → `PhosphorIconsBold.forkKnife`

### App bars

- `ClassicAppBar(leading, title, actions, bottomContent)` — standard app bar with gradient
- `TransparentAppBar` — overlaid on content (for hero-image screens)

---

## Code organisation inside a screen

### Private helper functions (keep in the same file)

Extract pieces of the `build` method into private functions when they reduce repetition:

```dart
Widget _buildHeader(BuildContext context) { ... }
Widget _buildItemTile(BuildContext context, Item item) { ... }
```

These functions do **not** become separate files.

### When to create a separate widget file

If a UI piece has its own state, many parameters, or is reused — create a separate file.

```
I have a piece of UI to isolate:
├─ Used in 3+ features?   → lib/core/widgets/base_widget_name.dart
├─ Used in ≤ 2 features?  → features/<name>/widgets/widget_name.dart
├─ Demo screen only?      → define in the same screen file (exception)
└─ Small repetition?      → private _buildXxx() function
```

### Exception — Template/demo screens

In `home_screen.dart`, `form_screen.dart` etc. it is acceptable to have multiple widget classes in the same file. This exception applies **only** to template demo screens.

---

## Design system

All colours, typography and spacing must use helpers. Full reference in `design-system.instructions.md`.
