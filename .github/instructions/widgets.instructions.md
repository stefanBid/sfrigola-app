---
applyTo: "**/widgets/**"
---

# Widgets — Placement, naming and API

## Placement rules

| Case | Where | Naming |
|---|---|---|
| Used in **≤ 2** features | `features/<name>/widgets/` | `widget_name.dart` |
| Used in **3+** features | `lib/core/widgets/` (root) | `base_widget_name.dart` |
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
  type: BaseButtonType.filled,           // filled | outlined | ghost
  fullWidth: true,
  pill: false,                           // true → borderRadiusSm (pill shape)
  isLoading: false,
  onPressed: () { ... },
)
```

- **`filled`** — `AppColors.primary` background, dark text. Use for primary CTA and form submit.
- **`outlined`** — transparent background, `AppColors.secondary` border + text. Use for secondary CTA.
- **`ghost`** — no background, no border, `AppColors.primary` text + ripple. Use for low-prominence actions (empty states, error pages, dialogs).
- **`pill: true`** — applies `AppDesign.borderRadiusSm` instead of `borderRadiusXs`. Use with `ghost` in contextual layouts (e.g. `MessagePageLayout`).

`AppColors.primary` is always primary — no dark mode swap.

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

Grid layout widget con lazy builder pattern. Accetta uno `ScrollController` opzionale per la gestione esterna dello scroll (es. infinite scroll, `_onScroll` listener).

```dart
GcGridView(
  itemCount: items.length,
  itemBuilder: (context, index) => MyCard(item: items[index]),
  scrollController: _scrollController, // optional
  dimensions: GridDimensions(
    crossAxisCount: 2,                        // number of columns (default: 2)
    childAspectRatio: 3 / 2,                 // width/height ratio — ignored when mainAxisExtent is set (default: 3/2)
    crossAxisSpacing: AppDesign.gapItemMd,   // horizontal gap (default)
    mainAxisSpacing: AppDesign.gapItemMd,    // vertical gap (default)
    mainAxisExtent: 280,                     // fixed item height in px — use to prevent cards from squashing on wide screens
    maxItemWidth: 300,                       // max width per cell; grid is centred and capped at maxItemWidth × columns + spacing
    padding: EdgeInsets.zero,                // inner GridView padding (default: EdgeInsets.zero — avoids MediaQuery top-padding gap)
  ),
)
```

**Notes:**
- `mainAxisExtent` overrides `childAspectRatio` — prefer it when a fixed height is needed (e.g. tablet grids)
- `maxItemWidth` computes `maxGridWidth = maxItemWidth × crossAxisCount + crossAxisSpacing × (crossAxisCount - 1)`; the grid is wrapped in `Align(topCenter) + ConstrainedBox` when set
- `padding` defaults to `EdgeInsets.zero` — Flutter's `GridView` would otherwise add `MediaQuery.padding.top` automatically as a top gap when the widget is not a primary scroll view

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

Inline label with semantic colour. Uses `borderRadiusXXs` and `caption` typography via `BadgeStyle`. Label text is always rendered in **uppercase**.

```dart
BaseBadge(
  label: 'New',
  icon: PhosphorIconsRegular.star, // optional
  style: BadgeStyle(
    color: AppColors.success,
    foregroundColor: Colors.white,       // optional — text, icon and border colour
    variant: BadgeVariant.filled,        // filled | outlined
    borderRadius: AppDesign.borderRadiusXXs, // optional override
  ),
)
```

**Colour logic:**
- `color` controls fill colour only
- `foregroundColor` controls text, icon **and border** colour
- `filled` → coloured background + border in `foregroundColor`
- `outlined` → transparent background + border in `foregroundColor`

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
  type: SnackBarType.success,  // success | error | warning | info (default)
  duration: const Duration(seconds: 3), // optional, default 3s
  retryLabel: 'Retry',         // optional — label for the action button
  onRetry: () { ... },         // optional — callback fired when the action button is tapped
);
```

When `onRetry` is provided, a `TextButton` with white bold text appears at the trailing end of the snack bar. Tapping it hides the snack bar and calls `onRetry`. Duration is **not** extended automatically — pass a custom `duration` if a longer window is needed.

| `SnackBarType` | Colour | Icon |
|---|---|---|
| `success` | `AppColors.success` | `checkCircle` |
| `error` | `AppColors.error` | `xCircle` |
| `warning` | `AppColors.warning` | `warningCircle` |
| `info` | `primary` / `secondary` (adaptive) | `info` |

Clears previous snack bars automatically before showing the new one. Uses `borderRadiusTopXs` (top corners only).

---

## BaseBottomSheet

Static utility for showing a modal bottom sheet. Never use `showModalBottomSheet` directly.

```dart
// Adaptive height — sheet grows with content
BaseBottomSheet.show(
  context,
  title: 'Filter',
  subtitle: 'Choose your preferences',
  child: myWidget,
);

// Fixed height — content scrolls if it exceeds the available space
BaseBottomSheet.show(
  context,
  heightFactor: 0.6,
  child: myLongList,
);
```

| Prop | Type | Description |
|---|---|---|
| `child` | `Widget` | Required. Content displayed inside the sheet. Always padded with `AppDesign.paddingPage`. |
| `title` | `String?` | Optional title rendered with `heading3`. |
| `subtitle` | `String?` | Optional subtitle rendered with `bodySecondary` + `muted`. |
| `heightFactor` | `double?` | Value in `(0, 1]`. Sheet height as a fraction of available screen height (status bar and home indicator excluded). Omit for adaptive height. |

**Behaviour:**
- Always clears active snack bars before opening
- Always full-width (`maxWidth: double.infinity`) — including landscape
- `useSafeArea: true` — Flutter handles notch and home indicator automatically
- With `heightFactor`: header fixed, `child` scrolls inside `SingleChildScrollView`
- Without `heightFactor`: sheet adapts to content height (`mainAxisSize.min`)
- Drag handle always visible at the top
- Background `surface`, top corners `borderRadiusTopMd`

---

## Design system

All colours, spacing and typography must come from helpers — never hardcode values. Full reference in `design-system.instructions.md`.
