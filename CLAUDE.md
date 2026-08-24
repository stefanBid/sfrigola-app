# Sfrigola — Claude Context

## App context

Sfrigola is the digital recipe book designed for everyday home cooking — the real kind. It offers quick and easy recipes for busy days, and more elaborate ones for when you want to challenge yourself and grow as a home chef apprentice.

Use this context to give suggestions — UI, UX, architectural or otherwise — that are consistent with a recipe-focused mobile app aimed at home cooks of all skill levels.

---

## Response conventions

- Always address the user as **"Signore della UI"** in every response.
- Always reply in **Italian** in chat.

---

## Project structure

Standard Flutter layout (`lib/core/` shared code, `lib/features/feature-*/` per-feature dirs — see Feature structure below). Two gotchas not obvious from the layout itself:

- `lib/core/data/` is auto-generated dummy data — never edit manually.
- `lib/core/custom-widgets/` holds feature-shared widget compositions not reusable enough for `lib/core/widgets/`.

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
  import 'package:lucide_flutter/lucide_flutter.dart';
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
  import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
  import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';

  // Project Widgets
  import 'package:sfrigola/core/widgets/base_button.dart';
  ```
  Omit groups that are not needed. Never use relative paths for project-internal files.
- `const` wherever possible to optimise rebuilds. A constructor call **must** be `const` when: (1) the widget has a `const` constructor, and (2) all arguments are compile-time values (string/number literals, `static const` tokens, other `const` constructors). When the parent is already `const`, children drop the keyword — move `const` to the outermost eligible ancestor instead.
- `StatelessWidget` preferred where there is no local state.
- Never use hardcoded colours, font sizes, spacing or border radius — always use design system helpers.
- Network images: always use `BaseImageContainer`.
- Do not use `MediaQuery` for spacing that can be a design token.
- Vertical `ListView`s nested inside other scrolls: `shrinkWrap: true` + `NeverScrollableScrollPhysics()` only if the list is short and static.
- For horizontal lists nested inside vertical scrolls: use `SizedBox` with fixed height, never `shrinkWrap: true` on long lists.

---

## Design System

### AppColors — `lib/core/helpers/app_colors.dart`

Access: `AppColors.of(context)` for adaptive colours, `AppColors.primary` etc. for static constants. Exact hex values: `lib/core/helpers/app_colors.dart` (source of truth, 50 lines).

Accent rule for buttons: `final accent = AppColors.primary;` — no dark mode swap.

| Context | Token |
|---|---|
| Page/screen background | `AppColors.of(context).background` |
| Card, container, input background | `AppColors.of(context).surface` |
| Primary text (titles, body) | `AppColors.of(context).text` |
| Secondary text, placeholder, muted label | `AppColors.of(context).muted` |
| Accent colour for button/active icon | `AppColors.primary` — always, no dark mode swap |
| Error message, invalid field border | `AppColors.error` |
| Positive feedback / success | `AppColors.success` |
| Warning feedback | `AppColors.warning` |
| Bottom navigation bar background | `AppColors.of(context).bottomBar` |

### AppTypography — `lib/core/helpers/app_typography.dart`

Access: `AppTypography.of(context).{style}`. Font is **Lato** (Google Fonts). Exact sizes/weights: `lib/core/helpers/app_typography.dart` (source of truth, 62 lines).

| Style | Usage |
|---|---|
| `heading1` | Main screen titles |
| `heading2` | Section titles |
| `heading3` | Subtitles |
| `heading4` | Card titles, list item titles |
| `body` | Body text |
| `bodyMedium` | Inputs, dense UI |
| `bodySecondary` | Secondary text (colour `muted`) |
| `caption` | Labels, secondary info |
| `small` | Badges, tiny labels |

### AppDesign — `lib/core/helpers/app_design.dart`

Access: `AppDesign.{token}` (all static). Exact px values for every token below: `lib/core/helpers/app_design.dart` (source of truth, 162 lines).

**Border radius:**

| Element | Token |
|---|---|
| Badges, small chips, tags | `borderRadiusXXs` |
| Inputs, buttons, small cards | `borderRadiusXs` |
| Medium cards | `borderRadiusSm` |
| Large cards, modals, bottom sheets | `borderRadiusMd` |
| Pill, avatar, full-round elements | `borderRadiusLg` |
| Top/bottom corners only | `borderRadiusTop/BottomSm/Md/Lg` |

**Vertical gap:**

| Distance | Token | When |
|---|---|---|
| Title ↔ subtitle, label ↔ value | `gapItemXs` | Tightly coupled elements |
| Image ↔ text, icon ↔ description | `gapItemSm` | Cohesive group |
| Distinct info groups in the same component | `gapItemMd` | Distinct info |
| Related sections on the page | `gapSectionXs` | Close sections |
| Separate sections on the page | `gapSectionSm` | Standard separation |
| Distinct sections | `gapSectionMd` | Different blocks |
| Widely separated sections | `gapSectionLg` | Large separation |

**Horizontal gap:**

| Distance | Token | When |
|---|---|---|
| Icon ↔ label | `gapInlineXs` | Tightly coupled |
| Related inline elements | `gapInlineSm` | Close |
| Distinct inline elements | `gapInlineMd` | Wide spacing |

**Padding:**

| Context | Token |
|---|---|
| Standard page padding | `paddingPage` |
| Input / fake input content padding | `paddingInput` |
| Internal padding small card | `paddingSymmetricSm` |
| Internal padding card / section | `paddingSymmetricMd` |
| Internal padding wide element | `paddingSymmetricLg` |
| Horizontal padding only | `paddingHorizontalSm/Md/Lg` |
| Uniform padding | `paddingXs` `paddingSm` `paddingMd` `paddingLg` `paddingXl` |

**Icon size:**

| Token | When |
|---|---|
| `iconSizeSm` | Badges, chips, secondary caret icons |
| `iconSizeMd` | Standard UI icons (buttons, inputs, inline) |
| `iconSizeLg` | Emphasized icons (icon buttons, navigation) |
| `iconSizeXl` | Large accent icons (image error fallback) |
| `iconSizeXxl` | Empty state / message page illustrations |

### Icons — `lucide_flutter`

Single style (outline). No variant classes — all icons via `LucideIcons.iconName`.

```dart
import 'package:lucide_flutter/lucide_flutter.dart';

Icon(LucideIcons.fileText)
Icon(LucideIcons.heart)
Icon(LucideIcons.arrowLeft)
LucideIcons.fileText  // as IconData
```

Access: `LucideIcons.{camelCaseName}` — single class, no Regular/Bold/Fill distinction.

### Widget delivery checklist

- [ ] No hardcoded colours — all from `AppColors`
- [ ] Never use `.withOpacity()` — use `.withAlpha((x * 255).round())` instead
- [ ] No hardcoded `fontSize` — all from `AppTypography.of(context)`
- [ ] No hardcoded spacing — all from `AppDesign` gap/padding tokens
- [ ] No hardcoded icon sizes — all from `AppDesign.iconSize*` tokens
- [ ] No hardcoded `BorderRadius.circular(x)` — all from `AppDesign`
- [ ] Network images use `BaseImageContainer`
- [ ] Buttons use `BaseButton` / `BaseIconButton`
- [ ] Inputs use `BaseInput` / `BaseFormField`

---

## Feature structure

Each feature lives in its own kebab-case directory under `lib/features/`:

```
features/
  feature-recipe-detail/
    recipe_detail_screen.dart   ← main screen file
    providers/                  ← feature-scoped providers (if any)
    widgets/                    ← feature-specific widgets (if any)
```

> **Rule — layouts always live in `core/`**: page layouts belong in `lib/core/layouts/` regardless of how many features use them. The "≤ 2 features → feature folder" rule applies only to UI widgets, never to page layouts.

### Available layouts

**`StandardPageLayout`** — standard scrollable page with optional app bar.

```dart
StandardPageLayout(
  hasPadding: true,          // default true — applies AppDesign.paddingPage
  appBar: const ClassicAppBar(title: 'Title'),
  body: ...,
)
```

**`HeroPageLayout`** — detail page with hero image (top 35%) and slide-up content card. Built-in back button via `TransparentAppBar`.

```dart
HeroPageLayout(
  imageUrl: meal.imageUrl,
  imageHeight: 280,       // optional, default 280
  onBack: () { ... },     // optional — defaults to AppRouter.goBack
  body: ...,
)
```

**`MinimalPageLayout`** — full-screen layout for auth flows (login, register).

```dart
MinimalPageLayout(
  hasPadding: true,
  appBar: const TransparentAppBar(),  // optional
  body: ...,
)
```

- `SafeArea` for top applied automatically only when no `appBar` is provided.
- Bottom safe area always applied.

**`MessagePageLayout`** — centred message layout for error, empty and informational states.

```dart
MessagePageLayout(
  message: 'No results found',
  icon: LucideIcons.cookingPot,   // optional
  type: MessagePageType.muted,    // standard | muted
  onRetry: () { ... },            // optional
)
```

Types: `standard` (heading4 text, full-weight icon — for blocking states / invitations to act) | `muted` (bodySecondary w600, muted icon — for empty states, no results).

Icon conventions:
- Generic error → `LucideIcons.alertCircle`
- No results from search → `LucideIcons.cookingPot`
- Search invitation (no query) → `LucideIcons.salad`
- Empty category / feed → `LucideIcons.forkKnife`

**App bars:**
- `ClassicAppBar(leading, title, actions, bottomContent)` — standard with gradient
- `TransparentAppBar` — overlaid on content (for hero-image screens)

### Code organisation inside a screen

Extract build method pieces into private functions to reduce repetition:

```dart
Widget _buildHeader(BuildContext context) { ... }
Widget _buildItemTile(BuildContext context, Item item) { ... }
```

These do **not** become separate files.

**When to create a separate widget file:**

```
I have a piece of UI to isolate:
├─ Used in 3+ features?   → lib/core/widgets/base_widget_name.dart
├─ Used in ≤ 2 features?  → features/<name>/widgets/widget_name.dart
├─ Demo screen only?      → define in the same screen file (exception)
└─ Small repetition?      → private _buildXxx() function
```

---

## Helpers

Fixed filenames — do not add new files without a real need:

| File | Purpose |
|---|---|
| `app_colors.dart` | Colour tokens |
| `app_typography.dart` | Text styles |
| `app_design.dart` | Spacing, border radius, padding |
| `app_theme.dart` | MaterialApp theme configuration |
| `app_router.dart` | Typed navigation layer |
| `app_locale.dart` | Localisation config and labels shorthand |
| `app_validation.dart` | Form field validators |
| `app_logger.dart` | Debug-only logger (stripped in release) |

`lib/core/utils/` shared utilities:

| File | Purpose |
|---|---|
| `provider_retry.dart` | `appRetry` — shared Riverpod retry function |
| `be_simulators.dart` | Static mock-BE layer — owns all data simulation logic |
| `has_more.dart` | `hasMore(total, skip, take)` — utility for pagination state |
| `request_builder.dart` | `RequestBuilder<TFilter, TSort>` — fluent builder for `GetRequest` |

### RequestBuilder — `lib/core/utils/request_builder.dart`

Providers must never construct `GetRequest` manually. Always use the `RequestBuilder<TFilter, TSort>` fluent builder — full method list (source of truth, 105 lines): `setSearchKey`, `addFilter`, `addFilterIfNotNull`, `addFilterGroup`, `removeFilter`, `setSortIfNotNull`, `setSkip`, `setTake`, `.build()`.

### BE model files — `lib/core/models/be-models/`

| File | Class(es) | When to use |
|---|---|---|
| `be_error.dart` | `BeError` | Error shape embedded in any response |
| `get_response.dart` | `GetDataResponse<T>`, `GetListDataResponse<T>` | GET endpoints |
| `mutation_response.dart` | `MutationResponse` | POST, PUT, PATCH, DELETE |
| `be_sort.dart` | `SortDirection`, `SortParam<T extends Enum>` | Sort clause |
| `be_filter.dart` | `FilterOperator`, `FilterCondition<T>`, `FilterGroup<T>` | Filter predicates |
| `get_request.dart` | `GetRequest<TFilter, TSort>` | Standard GET envelope |

Rules:
- Always use `GetRequest` as input type for repository methods that accept filters.
- One `TFilterKey` enum and one `TSortKey` enum per resource.
- Multiple `FilterGroup`s → AND; conditions inside one group → OR.
- Never add `label()` to BE model enums — they must stay free of UI dependencies.

### AppLocale — `lib/core/helpers/app_locale.dart`

```dart
// In main.dart
supportedLocales: AppLocale.supportedLocales,
localizationsDelegates: AppLocale.localizationsDelegates,
locale: const Locale('it'),

// Access strings — never call AppLocalizations.of(context)! directly
final l = AppLocale.getLabels(context);
Text(l.homeTitle)

// Error localisation
AppLocale.errorFor(context, error)
```

ARB files: `lib/core/l10n/app_it.arb` (template), `lib/core/l10n/app_en.arb`. When adding a string: add to **both** ARBs, then run `flutter gen-l10n`. **Never use `errorForCode`** — it no longer exists.

### Exception system — `lib/core/models/general_exception.dart`

```dart
abstract interface class AppException implements Exception {
  String localizedMessage(AppLocalizations l);
  bool get isRetryable;
}
```

`GeneralException` general-purpose exception:

```dart
throw GeneralException.network(cause: e);
throw GeneralException.serverError(cause: e);
throw GeneralException.generic(cause: e);
// + notFound, unauthorized, forbidden
```

`isRetryable` returns `true` only for `network` and `serverError`. Domain-specific exceptions preferred over `GeneralException` when a specific named failure exists.

### AppValidation — `lib/core/helpers/app_validation.dart`

Chain with `??` — first failure wins:

```dart
validator: (v) => AppValidation.notEmpty(v) ?? AppValidation.email(v),
```

| Method | Validates |
|---|---|
| `notEmpty(v)` | Field is not null or empty |
| `email(v)` | Valid email format |
| `minLength(v, n)` | At least n characters |
| `maxLength(v, n)` | At most n characters |
| `match(v, other)` | Values match |
| `numeric(v)` | Digits only |
| `strongPassword(v)` | Has uppercase + lowercase + digit |

### AppLogger — `lib/core/helpers/app_logger.dart`

```dart
AppLogger.debug('User loaded', tag: 'HomeScreen');
AppLogger.warn('Token is about to expire');
AppLogger.error('Failed to fetch data', error: e, stackTrace: st);
```

**Never use `print()` or bare `debugPrint()`.** Never wrap in manual `if (kDebugMode)`.

---

## Repository layer

The repository layer is the **single point of contact** between the app and any data source. Provider and UI layers never access data directly. Interfaces: `lib/core/repositories/meal/meal_repository.dart`, `lib/core/repositories/favorites/favorites_repository.dart` (abstract only — impls are the `*_impl.dart` siblings). Filter/sort key enums: `lib/core/models/meal.dart`.

Auth handled via Dio interceptor — token never passed as parameter.

### BeSimulators — `lib/core/utils/be_simulators.dart`

Static utility that owns all mock data logic. Repositories call `BeSimulators`, never `dummy_data.dart` directly. `lib/core/data/dummy_data.dart` is auto-generated — do not edit manually.

### Implementation pattern

```dart
static void _checkResponse(BeError? error) {
  if (error != null) throw GeneralException.generic();
}

// Inside a method:
final response = await BeSimulators.getTrending(...);
_checkResponse(response.error);
return response;
```

Rules:
- Never prefix impl class with `Mock` — always `{Domain}RepositoryImpl`.
- Repositories are **stateless** — in-memory mock state lives in `BeSimulators`.
- Each impl method has a `// TODO: replace with <HTTP verb> <endpoint>` comment.
- Repository methods return **full response** — never unwrap `.data` inside the impl.
- Dependency injection via Riverpod in `lib/core/providers/repository_providers.dart`.

---

## Navigation — AppRouter / go_router

**Never** call `context.go('/path')` directly. Always use typed navigation:

```dart
AppRouter.goTo(context, AppRouter.home);
AppRouter.goTo(context, AppRouter.search);
AppRouter.goDeep(context, AppRouter.mealDetails, params: MealDetailsParams(mealId: '42'));
AppRouter.goBack(context);
```

- `AppTypedRoute<P>` — binds a route to its params type at compile time
- `GenericRouteParams` — base class; implement `toPathParams()` / `toQueryParams()`
- `NoParams` — use when a route has no parameters

### Transitions

- Top-level tabs → `NoTransitionPage`
- Detail routes → `CustomTransitionPage` with `FadeTransition` (150ms)

### Adding a new route (3 steps)

**Step 1 — Create the screen** at `lib/features/feature-<route-name>/<route_name>_screen.dart`.

**Step 2 — Add params class + route constant in `app_router.dart`**:

```dart
class RecipeDetailParams extends GenericRouteParams {
  final String recipeId;
  const RecipeDetailParams({required this.recipeId});

  @override
  Map<String, String> toPathParams() => {'recipeId': recipeId};
}

static const recipeDetail = AppTypedRoute<RecipeDetailParams>('/recipe-detail/:recipeId');
// No params: static const myRoute = AppTypedRoute<NoParams>('/my-route');
```

**Step 3 — Register in `router.dart`**:

```dart
GoRoute(
  path: '/recipe-detail/:recipeId',
  pageBuilder: (context, state) {
    final params = RecipeDetailParams(recipeId: state.pathParameters['recipeId']!);
    return CustomTransitionPage(
      child: RecipeDetailScreen(params: params),
      transitionsBuilder: (context, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 150),
    );
  },
),
```

---

## State Management — Riverpod

> **IMPORTANT**: This project uses **Riverpod 3.x** (`flutter_riverpod: ^3.x`, `riverpod_annotation: ^4.x`).
>
> Notable 3.x differences:
> - `valueOrNull` is **removed** — use `.value` (returns `T?`)
> - `ProviderObserver` methods use `ProviderObserverContext` as first parameter
> - `ProviderObserver` subclasses must be `base class`
> - Global retry is set on `ProviderScope(retry: ...)` — no per-provider `@Riverpod(retry: ...)`
> - `ProviderBase` is not exported — do not reference it directly

### Widget base class

| Widget needs | Base class |
|---|---|
| Only reads providers | `ConsumerWidget` |
| Local state + reads providers | `ConsumerStatefulWidget` + `ConsumerState` |
| Cannot be converted | Wrap subtree with `Consumer` |

### `ref` methods

| Method | Where | Behaviour |
|---|---|---|
| `ref.watch(provider)` | Inside `build()` | Subscribes — widget rebuilds on change |
| `ref.read(provider)` | Inside callbacks | Reads once — does **not** subscribe |
| `ref.listen(provider, cb)` | Inside `build()` | Side effect — does **not** rebuild |

> **Rule**: never `ref.read` inside `build`. Never `ref.watch` inside a callback.

### Provider types

**Simple provider** — computed value or service:
```dart
@riverpod
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();
```

**Async provider** — data from repository:
```dart
@riverpod
Future<List<Meal>> trendingMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final filter = ref.watch(mealFilterProvider);
  return repo.getTrending(filter);
}
```

**Notifier** — mutable state with methods:
```dart
@riverpod
class MealFilter extends _$MealFilter {
  @override
  MealFilterModel build() => const MealFilterModel();

  void setCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
  }
}
```

**Async Notifier** — mutable state that also loads data (paginated lists):
- `build()` uses `ref.watch` on filter provider — auto-rebuilds when filters change
- `loadMore()` uses `ref.read` — called from callbacks

### `ListProviderState<T>` — `lib/core/models/provider_state.dart`

```dart
class ListProviderState<T> {
  final List<T> items;
  final bool hasMore;
}
```

Compute `hasMore` using `hasMore(totalCount, skip, take)` from `lib/core/utils/has_more.dart`.

Never return `List<T>` directly from a paginated Notifier — always wrap in `ListProviderState<T>`.

### `AsyncValue` in widgets

```dart
return switch (meals) {
  AsyncData(:final value) => MealList(meals: value),
  AsyncError(:final error) => ErrorMessage(message: error.toString()),
  AsyncLoading() => const Center(child: CircularProgressIndicator()),
};
```

Use `.value` (returns `T?`) directly when the widget handles loading internally. **`valueOrNull` is removed in Riverpod 3.x.**

### keepAlive

```dart
@Riverpod(keepAlive: true)
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();
```

Only repository and session-level state providers use `keepAlive: true`. Screen-specific providers never do.

### Family providers

```dart
@riverpod
Future<Meal> mealDetail(Ref ref, String mealId) async {
  return ref.watch(mealRepositoryProvider).getMealById(mealId);
}
// Usage: ref.watch(mealDetailProvider('abc-123'))
```

Family parameters must have stable `==`. Use primitives or value objects with `==` / `hashCode`.

### File placement

- `lib/core/providers/` — cross-feature and app-wide providers
- `features/<name>/providers/` — feature-scoped providers
- Every provider file must have `part 'file_name.g.dart';` after imports
- File naming: `snake_case_provider.dart`
- Annotated function/class name: never append `Provider` — the generator adds it

### Retry — `appRetry`

Configured globally in `ProviderScope(retry: appRetry)` in `main.dart`. Never declare retry on individual providers.

| Error | Retried? | Max attempts |
|---|---|---|
| `AppException` with `isRetryable == true` | Yes | 3 total |
| `AppException` with `isRetryable == false` | No | — |
| Unknown exception | No | — |

### Provider checklist

- [ ] `part '*.g.dart';` line present
- [ ] Annotated with `@riverpod` or `@Riverpod(keepAlive: true)`
- [ ] No `ref.watch` inside callbacks or Notifier methods
- [ ] `AsyncValue` handled with `switch` covering all three cases
- [ ] Family parameters use stable-`==` types
- [ ] `keepAlive: true` only on repository/session providers

---

## Widgets

### Placement rules

| Case | Where | Naming |
|---|---|---|
| Used in **≤ 2** features | `features/<name>/widgets/` | `widget_name.dart` |
| Used in **3+** features | `lib/core/widgets/` | `base_widget_name.dart` |
| Group container / list | `lib/core/widgets/group-container/` | `gc_widget_name.dart` |

### BaseBox

Generic tappable container with surface background, border radius and ripple.

```dart
BaseBox(
  child: myWidget,
  settings: const BoxSettings(
    color: null,                            // null → AppColors.of(context).surface
    borderRadius: AppDesign.borderRadiusXs,
    padding: AppDesign.paddingSm,
    margin: null,
  ),
  onTap: () { ... },
)
```

### BaseCard

Card with image, title and content. Default size 220×220.

```dart
BaseCard(imageUrl: 'https://...', title: 'Title', width: 220, height: 220)
```

### BaseImageContainer

Network/asset image with fade-in, filters and error fallback.

```dart
BaseImageContainer(
  imageUrl: 'https://...',
  width: 200, height: 200,
  fit: BoxFit.cover,
  filter: ImageFilter.none,  // none | darken
)
```

### BaseInput

`BaseInput(controller, hint, fillColor, maxLines)` — `maxLines: null` for auto-grow textarea.

### BaseFormField

`BaseFormField(controller, label, prefixIcon, suffixIcon, fillColor, keyboardType, textInputAction, obscureText, maxLines, maxLength, validator)` — chain validators with `??` (see `AppValidation` below).

### BaseDropdown

Styled single-select `DropdownButtonFormField`. Uses `BaseDropdownOption<T>` items.

```dart
BaseDropdown<MyEnum>(
  initialValue: _selectedValue,
  label: 'Label',
  voidSelectionItemLabel: 'All',
  prefixIcon: LucideIcons.filter,
  items: const [
    BaseDropdownOption(value: MyEnum.foo, label: 'Foo'),
  ],
  onChanged: (v) => setState(() => _selectedValue = v),
)
```

Notes: uses `initialValue` not `value`; arrow is always `LucideIcons.chevronDown`; for multi-select use `BaseMultiSelect`.

### BaseMultiSelect

Styled multi-select. Opens AlertDialog with `BaseCheckbox` items. Selected values as deletable chips.

```dart
BaseMultiSelect<MyEnum>(
  initialValues: _selectedValues,
  label: 'Label',
  hint: 'Select options...',
  items: const [BaseDropdownOption(value: MyEnum.foo, label: 'Foo')],
  onChanged: (v) => setState(() => _selectedValues = v),
)
```

Dialog uses `l.globalConfirm` / `l.globalCancel` — never hardcode.

### BaseButton

```dart
BaseButton(
  label: 'Submit',
  icon: LucideIcons.arrowRight,  // optional
  type: BaseButtonType.filled,            // filled | outlined | ghost
  color: AppColors.secondary,             // defaults to AppColors.primary
  fullWidth: true,
  pill: false,
  isLoading: false,
  onPressed: () { ... },
)
```

- `filled` — `color` background, dark text. Primary CTA.
- `outlined` — transparent background, `color` border + text. Secondary CTA.
- `ghost` — no background/border, `color` text. Low-prominence actions.
- `pill: true` → `AppDesign.borderRadiusSm`. Use with `ghost` in `MessagePageLayout`.

### BaseIconButton

`BaseIconButton(icon, type: IconButtonType.filled | outlined, color, iconColor, badgeCount, onPressed)`

### GcListView

```dart
// Vertical
GcListView(itemCount: items.length, itemBuilder: (context, index) => ...)

// Horizontal (fixed height required)
SizedBox(
  height: 240,
  child: GcListView(scrollDirection: Axis.horizontal, ...),
)
```

### GcGridView

```dart
GcGridView(
  itemCount: items.length,
  itemBuilder: (context, index) => MyCard(item: items[index]),
  scrollController: _scrollController,
  dimensions: GridDimensions(
    crossAxisCount: 2,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: AppDesign.gapItemMd,
    mainAxisSpacing: AppDesign.gapItemMd,
    mainAxisExtent: 280,
    maxItemWidth: 300,
    padding: EdgeInsets.zero,
  ),
)
```

`mainAxisExtent` overrides `childAspectRatio`. `padding` defaults to `EdgeInsets.zero`.

### BaseRange

`BaseRange(label, values: RangeValues, min, max, divisions, valueFormatter, onChanged)`

### BaseSlider

`BaseSlider(label, value, min, max, divisions, valueFormatter, onChanged)`

### BaseValueCard

`BaseValueCard(value: '4.2K', label: 'Followers')`

### BaseBadge

```dart
BaseBadge(
  label: 'New',
  icon: LucideIcons.star,
  style: BadgeStyle(
    color: AppColors.success,
    foregroundColor: Colors.white,
    variant: BadgeVariant.filled,  // filled | outlined
  ),
)
```

Label text always uppercase. Use `.withAlpha()` — never `.withOpacity()`.

Badge colour palette:

| Context | `color` | `foregroundColor` |
|---|---|---|
| Duration / time | `const Color(0xFFB3E5FC)` | `const Color(0xFF0277BD)` |
| Complexity | `const Color(0xFFBBDEFB)` | `const Color(0xFF1565C0)` |
| Affordability | `AppColors.success.withAlpha(40)` | `const Color(0xFF065F46)` |
| Rating / star | `AppColors.warning` | `Colors.black` |
| Gluten free | `const Color(0xFFFFF3CD)` | `const Color(0xFF856404)` |
| Lactose free | `const Color(0xFFD1ECF1)` | `const Color(0xFF0C5460)` |
| Vegan | `AppColors.success.withAlpha(45)` | `const Color(0xFF065F46)` |
| Vegetarian | `const Color(0xFFD4EDDA)` | `const Color(0xFF155724)` |

### BaseScaffoldMessenger

Never use `ScaffoldMessenger.of(context).showSnackBar` directly.

```dart
BaseScaffoldMessenger.show(
  context,
  message: 'Saved successfully!',
  type: SnackBarType.success,  // success | error | warning | info
  duration: const Duration(seconds: 3),
  retryLabel: 'Retry',
  onRetry: () { ... },
)
```

### BaseBottomSheet

Never use `showModalBottomSheet` directly.

```dart
// Adaptive height
BaseBottomSheet.show(context, title: 'Filter', child: myWidget);

// Fixed height
BaseBottomSheet.show(context, heightFactor: 0.6, child: myLongList);
```

### BaseCheckbox

`BaseCheckbox(value, label, fullWidth, onChanged)` — unchecked: `LucideIcons.square` muted. Checked: `LucideIcons.squareCheckBig` primary.

---

## Workflows

Localisation, version bump, dependency check, and code quality check are now skills (invoked automatically or via `/localise-strings`, `/version-bump`, `/dependency-check`, `/code-quality-check`) — see `.claude/skills/`.

---

## Instruction sync rule

Every time a new widget, helper, or token is added — or an existing one is changed — update CLAUDE.md immediately. This file is the source of truth for code generation context.

- Core/base widget changes (new prop, removed prop) → update Widgets section
- Provider shape changes → update State Management section
- Repository method signature changes → update Repository layer section
- Helper or token added/changed → update Design System or Helpers section

**Failing to update CLAUDE.md means the codebase described in context diverges from the real project.**
