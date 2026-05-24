---
applyTo: "**/providers/**,**/features/**,**/widgets/**"
---

# State Management — Riverpod conventions

> **IMPORTANT**: This project uses **Riverpod 3.x** (`flutter_riverpod: ^3.x`, `riverpod_annotation: ^4.x`). All patterns, APIs and examples in this file are Riverpod 3.x only. Do not suggest APIs, workarounds or patterns from Riverpod 1.x or 2.x — they are incompatible.
>
> Notable Riverpod 3.x differences to keep in mind:
> - `valueOrNull` is **removed** — use `.value` (returns `T?`)
> - `ProviderObserver` methods use `ProviderObserverContext` as first parameter
> - `ProviderObserver` subclasses must be declared `base class`
> - Global retry is set on `ProviderScope(retry: ...)` — no per-provider `@Riverpod(retry: ...)`
> - `ProviderBase` is not exported — do not reference it directly

Stack: `flutter_riverpod` + `riverpod_annotation` + `riverpod_generator`.

---

## Package roles

| Package | Role |
|---|---|
| `flutter_riverpod` | Flutter bindings — `ProviderScope`, `ConsumerWidget`, `ConsumerStatefulWidget`, `WidgetRef` |
| `riverpod_annotation` | `@riverpod` annotation used to declare providers |
| `riverpod_generator` | Code-gen — reads `@riverpod` and emits the actual provider objects (run with `dart run build_runner watch -d`) |

---

## File placement

Providers live in `lib/core/providers/`. Organise by domain **only when the domain has 3+ provider files** — otherwise keep flat.

**Cross-feature core providers** — even when a provider depends on a feature-scoped provider (e.g. a filter), place it in `lib/core/providers/` if it is consumed by the feature itself as its primary data source or shared with other features:

```
lib/core/providers/
  repository_provider.dart      ← all repository singletons
  all_meals_provider.dart       ← cross-feature: search results (family provider, accepts String? searchKey)
  all_favourites_provider.dart  ← cross-feature: favourites list (depends on feature-favourites' favouritesFilterProvider)
```

**Flat (≤ 2 files per domain):**
```
lib/core/providers/
  repository_provider.dart   ← all repository singletons
  meal_provider.dart         ← meal data providers
  meal_filter_provider.dart  ← meal filter Notifier
  favorites_provider.dart    ← favorites AsyncNotifier
```

**By domain (when a domain grows to 3+ files):**
```
lib/core/providers/
  meal/
    meal_repository_provider.dart
    meal_provider.dart
    meal_filter_provider.dart
  favorites/
    favorites_repository_provider.dart
    favorites_provider.dart
```

> **Rule**: `repository_provider.dart` stays flat as long as there are ≤ 4 repositories. Split into domain subdirectories only when the flat list becomes hard to navigate.

**Feature-scoped providers** (used only inside one feature) live inside the feature directory:
```
features/feature-home/
  providers/
    meals_provider.dart
    categories_provider.dart
    selected_category_id_provider.dart
```

Every provider file must end with `// ignore_for_file: avoid_public_notifier_properties` only when needed. Otherwise no file-level ignores.

Always add `part 'file_name.g.dart';` after the imports — the code generator writes there.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';

part 'meal_provider.g.dart';
```

---

## Widget base class — choosing the right one

| Widget needs | Base class |
|---|---|
| Only reads providers — no local state | `ConsumerWidget` |
| Local state (controller, form key, flag, …) **and** reads providers | `ConsumerStatefulWidget` + `ConsumerState` |
| Cannot be converted (already extends something else) | Wrap the reactive subtree with `Consumer` |

```dart
// Good — only providers, no local state
class MealCard extends ConsumerWidget {
  const MealCard({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(meal.id));
    return Text(isFavorite ? '❤️' : '🤍');
  }
}

// Good — local state (TextEditingController) + providers
class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({super.key});

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchProvider(_controller.text));
    return TextField(controller: _controller);
  }
}
```

---

## `ref` methods — when to use which

| Method | Where | Behaviour |
|---|---|---|
| `ref.watch(provider)` | Inside `build()` | Subscribes — widget rebuilds on change |
| `ref.read(provider)` | Inside callbacks (`onPressed`, `onChanged`) | Reads once — does **not** subscribe |
| `ref.listen(provider, cb)` | Inside `build()` | Side effect on change (SnackBar, navigation) — does **not** rebuild |

> **Rule**: never call `ref.read` inside `build`. Never call `ref.watch` inside a callback.

```dart
// Good
@override
Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterProvider); // ✓ in build

  return ElevatedButton(
    onPressed: () => ref.read(counterProvider.notifier).increment(), // ✓ in callback
    child: Text('$count'),
  );
}
```

---

## Declaring providers with `@riverpod`

### Simple provider (function) — computed value or service

Use for: repository instances, derived values, constants.

```dart
@riverpod
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();

@riverpod
String greeting(Ref ref) => 'Hello!';
```

Generated name: `mealRepositoryProvider`, `greetingProvider`.

### Async provider (function) — data from repository / API

Use for: lists, single items, anything that requires `await`.

```dart
@riverpod
Future<List<Meal>> trendingMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final filter = ref.watch(mealFilterProvider);
  return repo.getTrending(filter);
}
```

Generated name: `trendingMealsProvider`. Return type seen by widgets: `AsyncValue<List<Meal>>`.

### Notifier — mutable state with methods

Use for: filters, toggles, shopping cart, any state the user can change.

```dart
@riverpod
class MealFilter extends _$MealFilter {
  @override
  MealFilterModel build() => const MealFilterModel(); // initial state

  void setCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void reset() => state = const MealFilterModel();
}
```

Generated name: `mealFilterProvider`.

- Read current state: `ref.watch(mealFilterProvider)`
- Call a method: `ref.read(mealFilterProvider.notifier).setCategory('italian')`

### Async Notifier — mutable state that also loads data

Use for: paginated lists that respond to a filter Notifier.

```dart
@riverpod
class AllFavouritesByFilter extends _$AllFavouritesByFilter {
  static const _pageSize = 20;

  @override
  Future<ListProviderState<MealPreview>> build() async {
    final filterState = ref.watch(
      mealsFilterProvider(MealsFilterScope.favorites),
    );
    final request = _buildRequest(filterState: filterState, skip: 0);
    final response = await ref
        .watch(favoritesRepositoryProvider)
        .getFavorites(request);
    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];
    final filterState = ref.read(
      mealsFilterProvider(MealsFilterScope.favorites),
    );
    final request = _buildRequest(
      filterState: filterState,
      skip: current.length,
    );
    final response = await ref
        .read(favoritesRepositoryProvider)
        .getFavorites(request);
    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }

  GetRequest<MealFilterKey, MealSortKey> _buildRequest({
    required MealsFilterProviderState filterState,
    required int skip,
  }) {
    return RequestBuilder<MealFilterKey, MealSortKey>()
        .addFilterIfNotNull(
          MealFilterKey.complexity,
          FilterOperator.equals,
          filterState.complexity,
        )
        .addFilterIfNotNull(
          MealFilterKey.affordability,
          FilterOperator.equals,
          filterState.affordability,
        )
        .setSortIfNotNull(filterState.sort)
        .setSkip(skip)
        .setTake(_pageSize)
        .build();
  }
}
```

**Rules:**
- `build()` uses `ref.watch` on the filter provider — it auto-rebuilds when filters change, restarting from page 0.
- `loadMore()` uses `ref.read` — it is called from a callback, not from `build`.
- The repository always returns `GetListDataResponse<T>` — map it to `ListProviderState<T>` using `response.data` and `hasMore(response.total, skip, _pageSize)`.
- Never return `List<T>` directly from a paginated Notifier — always wrap in `ListProviderState<T>`.

---

## `ListProviderState<T>` — paginated list state wrapper

Defined in `lib/core/models/provider_state.dart`. Used as the state type for every paginated list Async Notifier.

```dart
class ListProviderState<T> {
  final List<T> items;
  final bool hasMore;
  // + copyWith
}
```

| Field | Type | Description |
|---|---|---|
| `items` | `List<T>` | Accumulated items across all loaded pages |
| `hasMore` | `bool` | `true` if there are more pages to load |

Compute `hasMore` using the utility from `lib/core/utils/has_more.dart`:
```dart
bool hasMore(int totalCount, int skip, int take)
// => skip + take < totalCount
```

---

## `RequestBuilder<TFilter, TSort>` — building `GetRequest` in providers

Providers never construct `GetRequest` directly — they use `RequestBuilder` (from `lib/core/utils/request_builder.dart`) for a fluent, null-safe chain:

```dart
RequestBuilder<MealFilterKey, MealSortKey>()
    .setSearchKey(searchKey)           // String? — skipped when null
    .addFilter(MealFilterKey.category, FilterOperator.equals, categoryId)
    .addFilterIfNotNull(MealFilterKey.complexity, FilterOperator.equals, complexity)
    .addFilterGroup(FilterGroup(conditions: [...]))  // multi-condition OR group
    .setSortIfNotNull(sortParam)       // SortParam<TSort>? — skipped when null
    .setSkip(skip)
    .setTake(pageSize)
    .build();                          // returns GetRequest<TFilter, TSort>
```

**Key methods:**

| Method | Effect |
|---|---|
| `setSearchKey(String?)` | Sets `searchKey`; ignored when null |
| `addFilter(key, op, value)` | Adds a single-condition `FilterGroup` (AND with other groups) |
| `addFilterIfNotNull(key, op, value?)` | Like `addFilter` but no-op when value is null — for optional filters |
| `addFilterGroup(FilterGroup)` | Adds a pre-built multi-condition OR group |
| `removeFilter(key)` | Removes all groups that contain at least one condition with `key` |
| `setSortIfNotNull(SortParam?)` | Sets sort; no-op when null |
| `setSkip(int)` | Offset for pagination (default 0) |
| `setTake(int)` | Page size (default 20) |
| `build()` | Returns an immutable `GetRequest<TFilter, TSort>` |

---

## Provider dependencies

Providers can watch other providers — they recompute automatically when a dependency changes.

```dart
@riverpod
Future<ListProviderState<MealPreview>> trendingMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final request = GetRequest<MealFilterKey, MealSortKey>();  // default: skip=0, take=20
  final response = await repo.getTrending(request);
  return ListProviderState(
    items: response.data,
    hasMore: hasMore(response.total, 0, 20),
  );
}
```

> **Rule**: always use `ref.watch` (not `ref.read`) inside a provider body — this establishes the reactive dependency.

---

## Using `AsyncValue` in widgets

All async providers return `AsyncValue<T>`. Handle all three states using `switch`:

```dart
final meals = ref.watch(trendingMealsProvider);

return switch (meals) {
  AsyncData(:final value) => MealList(meals: value),
  AsyncError(:final error) => ErrorMessage(message: error.toString()),
  AsyncLoading() => const Center(child: CircularProgressIndicator()),
};
```

In alternativa, quando il widget ha già un suo stato di loading gestito internamente (come `MealsGroupRow`), usa `.value` direttamente — in Riverpod 3.x restituisce già `T?` (null se loading o error):

```dart
Consumer(
  builder: (context, ref, _) {
    final async = ref.watch(trendingMealsProvider);
    return MealsGroupRow(
      isLoading: async.isLoading,
      meals: async.value ?? [], // T? in Riverpod 3.x — null se loading/error
    );
  },
),
```

> **Nota Riverpod 3.x**: `valueOrNull` è stato rimosso. Usa sempre `.value` che restituisce `T?`.

---

## `keepAlive` — controlling provider lifetime

By default, a provider is destroyed when it has no more listeners. To keep it alive across navigation (e.g. user session, global filter):

```dart
@Riverpod(keepAlive: true)
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();
```

> **Rule**: only repository providers and session-level state use `keepAlive: true`. Screen-specific providers never do.

---

## Family providers — parametric providers

Use when the same provider logic depends on a runtime parameter (e.g. a meal ID).

```dart
@riverpod
Future<Meal> mealDetail(Ref ref, String mealId) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getMealById(mealId);
}
```

Usage in widget: `ref.watch(mealDetailProvider('abc-123'))`.

> **Rule**: family parameters must have a stable `==`. Use primitive types (`String`, `int`, `bool`) or value objects that override `==` and `hashCode`.

---

## Naming conventions

| Element | Style | Example |
|---|---|---|
| Provider function / class | `camelCase` / `PascalCase` | `trendingMeals` → generates `trendingMealsProvider` |
| Provider file | `snake_case_provider.dart` | `meal_provider.dart` |
| Notifier state model | `PascalCase` + `Model` suffix | `MealFilterModel` |

> **Rule**: the generator appends `Provider` automatically. Never write `...Provider` in the annotated function/class name.

---

## Import order for provider files

```dart
import 'package:flutter/material.dart'; // only if needed
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository_impl.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';

part 'meal_provider.g.dart';
```

---

## Checklist before committing a provider

- [ ] File is in `lib/core/providers/` (or feature `providers/`) and named `*_provider.dart`
- [ ] `part '*.g.dart';` line is present
- [ ] Annotated with `@riverpod` or `@Riverpod(keepAlive: true)`
- [ ] Async providers that call a repository use plain `@riverpod` (retry is global)
- [ ] Notifier `build()` returns the initial state / initial Future
- [ ] No `ref.watch` inside callbacks or Notifier methods (use `ref.read` there)
- [ ] `AsyncValue` is handled with `switch` covering all three cases
- [ ] Family parameters use only stable-`==` types
- [ ] `keepAlive: true` only on repository/session providers

---

## Retry — `appRetry`

The retry policy is configured **globally** in `ProviderScope` via `retry: appRetry`. Every provider inherits it automatically — **never** declare `@Riverpod(retry: appRetry)` on individual providers.

```dart
// main.dart — already configured, do not duplicate
ProviderScope(
  retry: appRetry,
  child: const MyApp(),
)
```

All async providers that call a repository simply use `@riverpod`:

```dart
@riverpod
class MealById extends _$MealById {
  @override
  Future<Meal> build(String mealId) async {
    return ref.watch(mealRepositoryProvider).getMealById(mealId);
  }
}
```

**Policy** (defined in `appRetry` — do not replicate inline):

| Error | Retried? | Max attempts |
|---|---|---|
| `AppException` with `isRetryable == true` (network, serverError) | Yes | 3 total (2 retries) |
| `AppException` with `isRetryable == false` (notFound, unauthorized, forbidden, generic) | No | — |
| Unknown exception (not `AppException`) | No | — |

After all retries are exhausted the provider enters `AsyncError` — handle it in the widget with `AsyncError(:final error)` and show `AppLocale.errorFor(context, error)`.
