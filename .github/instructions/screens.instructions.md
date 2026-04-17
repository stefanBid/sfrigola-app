---
applyTo: "**/feature-*/**"
---

# Screens — Structure and conventions

## File placement

Each screen lives in its own kebab-case feature directory under `lib/`:

```
feature-recipe-detail/
  recipe_detail_screen.dart   ← main screen file
  providers/                  ← feature-scoped providers (if any)
  widgets/                    ← screen-specific widgets (if any)
    ingredient_chip.dart
```

- Directory: **`feature-` + kebab-case** (`feature-recipe-detail/`)
- File: **snake_case** (`recipe_detail_screen.dart`)
- Class: **PascalCase** (`RecipeDetailScreen`)
- Create `widgets/` and `providers/` sub-directories as needed

---

## Available layouts

### `StandardPageLayout`

Standard scrollable page with optional app bar. Import from `core/layouts/body/standard_page_layout.dart`.

```dart
StandardPageLayout(
  hasPadding: true,          // default true — applies AppDesign.paddingPage
  appBar: const ClassicAppBar(title: 'Title'),
  body: ...,
)
```

### `AppLayout`

Shell layout with bottom navigation bar. Used via `ShellRoute` — do not instantiate directly.

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
├─ Used in 3+ screens?     → lib/widgets/base_widget_name.dart
├─ Used in ≤ 2 screens?    → screens/<name>/widgets/widget_name.dart
├─ Demo screen only?       → define in the same screen file (exception)
└─ Small repetition?       → private _buildXxx() function
```

### Exception — Template/demo screens

In `home_screen.dart`, `form_screen.dart` etc. it is acceptable to have multiple widget classes in the same file. This exception applies **only** to template demo screens.

---

## Design system

All colours, typography and spacing must use helpers. Full reference in `design-system.instructions.md`.
