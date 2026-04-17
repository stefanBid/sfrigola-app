---
applyTo: "**/widgets/**"
---

# Widgets — Placement, naming and API

## Placement rules

| Case | Where | Naming |
|---|---|---|
| Used in **≤ 2** screens | `feature-<name>/widgets/` | `widget_name.dart` |
| Used in **3+** screens | `lib/core/widgets/` (root) | `base_widget_name.dart` |
| Group container / list | `lib/core/widgets/group-container/` | `gc_widget_name.dart` |

---

## BaseBox

Generic tappable container with surface background, border radius and ripple. Use it as a building block for clickable cards, rows, and any pressable surface that doesn't need an image.

```dart
BaseBox(
  child: myWidget,
  settings: const BoxSettings(
    color: null,                          // null → AppColors.of(context).surface
    borderRadius: AppDesign.borderRadiusXs, // default
    padding: AppDesign.paddingSm,           // default
    margin: null,                           // optional
  ),
  onTap: () { ... }, // null → not tappable
)
```

**Defaults** (omit `settings` entirely to use them):
- `color` → `AppColors.of(context).surface`
- `borderRadius` → `AppDesign.borderRadiusXs`
- `padding` → `AppDesign.paddingSm`

---

## BaseCard

Card with image, title and content. Default size 220×220. Uses `BaseImageContainer` internally.

```dart
BaseCard(
  imageUrl: 'https://...',
  title: 'Title',
  width: 220,
  height: 220,
)
```

---

## BaseImageContainer

Network/asset image with fade-in, filters and error fallback.

```dart
BaseImageContainer(
  imageUrl: 'https://...',
  width: 200,
  height: 200,
  fit: BoxFit.cover,        // cover | contain
  filter: ImageFilter.none, // none | darken
)
```

---

## BaseInput

Styled `TextField`. Use `BaseFormField` inside `Form` widgets.

```dart
BaseInput(
  controller: controller,
  hint: 'Search...',
  fillColor: AppColors.of(context).surface, // optional
)
```

---

## BaseFormField

Styled `TextFormField` for use inside a `Form`.

```dart
BaseFormField(
  controller: controller,
  label: 'Email',
  prefixIcon: PhosphorIconsRegular.envelope, // IconData? — rendered internally with muted colour
  suffixIcon: IconButton(...),               // Widget? — use for buttons (e.g. show-password)
  fillColor: AppColors.of(context).surface,
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  obscureText: false,
  validator: (v) => AppValidation.notEmpty(v) ?? AppValidation.email(v),
)
```

---

## BaseButton

```dart
BaseButton(
  label: 'Submit',
  icon: PhosphorIconsRegular.arrowRight, // optional
  type: BaseButtonType.filled,           // filled | outlined
  fullWidth: true,
  isLoading: false,
  onPressed: () { ... },
)
```

Accent colour resolved automatically: `primary` in light mode, `secondary` in dark mode.

---

## BaseIconButton

```dart
BaseIconButton(
  icon: PhosphorIconsRegular.plus,
  type: IconButtonType.filled, // filled | outlined  (enum: IconButtonType)
  onPressed: () { ... },
)
```

---

## GcListView

Wrapped `ListView.builder`. For horizontal lists, wrap in a `SizedBox` with a fixed height.

```dart
// Vertical
GcListView(
  itemCount: items.length,
  itemBuilder: (context, index) => ...,
)

// Horizontal (fixed height required)
SizedBox(
  height: 240,
  child: GcListView(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (context, index) => ...,
  ),
)
```

---

## GcGridView

Grid layout widget. Pass widgets directly as a `children` list.

```dart
GcGridView(
  children: [
    widget1,
    widget2,
  ],
  dimensions: const GridDimensions(
    crossAxisCount: 2,           // number of columns (default: 2)
    childAspectRatio: 3 / 2,    // width/height ratio (default: 3/2)
    crossAxisSpacing: AppDesign.gapItemMd, // horizontal gap
    mainAxisSpacing: AppDesign.gapItemMd,  // vertical gap
  ),
)
```

---

## BaseValueCard

Card that displays a value and a label. Use for stats, KPIs, counts, or any labeled numeric/text value.

```dart
BaseValueCard(
  value: '4.2K',
  label: 'Followers',
)
```

---

## BaseBadge

Inline label with semantic colour. Uses `borderRadiusXXs` and `small`/`caption` typography via `BadgeStyle`.

```dart
BaseBadge(
  label: 'New',
  icon: PhosphorIconsRegular.star, // optional
  style: BadgeStyle(
    color: AppColors.success,
    foregroundColor: Colors.white,       // optional — text and icon colour
    size: BadgeSize.normal,              // normal (caption) | small
    variant: BadgeVariant.filled,        // filled | outlined
    borderRadius: AppDesign.borderRadiusXXs, // optional override
  ),
)
```

**Colour logic:**
- `color` controls both fill and border colour in both variants
- `filled` → coloured background + matching border
- `outlined` → transparent background + border in `color` colour
- `foregroundColor` → text and icon only (independent from border)

**Badge colour palette — approved combinations** (use these for consistency):

| Context | `color` | `foregroundColor` |
|---|---|---|
| Duration / time | `const Color(0xFFB3E5FC)` | `const Color(0xFF0277BD)` |
| Complexity | `const Color(0xFFBBDEFB)` | `const Color(0xFF1565C0)` |
| Affordability / budget | `AppColors.success.withAlpha(40)` | `const Color(0xFF065F46)` |
| Rating / star | `AppColors.warning` | `Colors.black` |
| Gluten free | `const Color(0xFFFFF3CD)` | `const Color(0xFF856404)` |
| Lactose free | `const Color(0xFFD1ECF1)` | `const Color(0xFF0C5460)` |
| Vegan | `AppColors.success.withAlpha(45)` | `const Color(0xFF065F46)` |
| Vegetarian | `const Color(0xFFD4EDDA)` | `const Color(0xFF155724)` |

> Use `.withAlpha()` — never `.withOpacity()` (near-deprecated in Flutter).

---

## BaseScaffoldMessenger

Static utility for showing styled snack bars. Never use `ScaffoldMessenger.of(context).showSnackBar` directly.

```dart
BaseScaffoldMessenger.show(
  context,
  message: 'Saved successfully!',
  type: SnackBarType.success, // success | error | warning | info (default)
);
```

| `SnackBarType` | Colour | Icon |
|---|---|---|
| `success` | `AppColors.success` | `checkCircle` |
| `error` | `AppColors.error` | `xCircle` |
| `warning` | `AppColors.warning` | `warningCircle` |
| `info` | `primary` / `secondary` (adaptive) | `info` |

Clears previous snack bars automatically before showing the new one. Uses `borderRadiusTopXs` (top corners only).

---

## Design system

All colours, spacing and typography must come from helpers — never hardcode values. Full reference in `design-system.instructions.md`.
