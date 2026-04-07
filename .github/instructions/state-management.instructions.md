---
applyTo: "**/providers/**,**/screens/**,**/widgets/**"
---

# State Management — Riverpod conventions

Stack: `hooks_riverpod` + `flutter_hooks` + `riverpod_annotation` + `riverpod_generator`.

---

## Package roles

| Package | Role |
|---|---|
| `hooks_riverpod` | Flutter bindings — `ProviderScope`, `ConsumerWidget`, `HookConsumerWidget`, `WidgetRef` |
| `flutter_hooks` | Local state hooks (`useState`, `useTextEditingController`, `useAnimationController`, …) |
| `riverpod_annotation` | `@riverpod` annotation used to declare providers |
| `riverpod_generator` | Code-gen — reads `@riverpod` and emits the actual provider objects (run with `dart run build_runner watch -d`) |

---

## File placement

Providers live in `lib/providers/`. Organise by domain **only when the domain has 3+ provider files** — otherwise keep flat.

**Flat (≤ 2 files per domain):**
```
lib/providers/
  repository_provider.dart   ← all repository singletons
  meal_provider.dart         ← meal data providers
  meal_filter_provider.dart  ← meal filter Notifier
  favorites_provider.dart    ← favorites AsyncNotifier
```

**By domain (when a domain grows to 3+ files):**
```
lib/providers/
  meal/
    meal_repository_provider.dart
    meal_provider.dart
    meal_filter_provider.dart
  favorites/
    favorites_repository_provider.dart
    favorites_provider.dart
```

> **Rule**: `repository_provider.dart` stays flat as long as there are ≤ 4 repositories. Split into domain subdirectories only when the flat list becomes hard to navigate.

Every provider file must end with `// ignore_for_file: avoid_public_notifier_properties` only when needed. Otherwise no file-level ignores.

Always add `part 'file_name.g.dart';` after the imports — the code generator writes there.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository.dart';
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

part 'meal_provider.g.dart';
```

---

## Widget base class — choosing the right one

| Widget needs | Base class |
|---|---|
| Only reads providers — no local state | `ConsumerWidget` |
| Local state (controller, animation, flag) **and** reads providers | `HookConsumerWidget` |
| Cannot be converted (already extends something else) | Wrap the reactive subtree with `Consumer` |

> **Rule**: never use `HookConsumerWidget` as the default for all widgets. Use it only when Flutter Hooks are actually needed.

```dart
// Good — only providers, no hooks needed
class MealCard extends ConsumerWidget {
  const MealCard({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(meal.id));
    return Text(isFavorite ? '❤️' : '🤍');
  }
}

// Good — needs a TextEditingController (hook) + a provider
class SearchBar extends HookConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final results = ref.watch(searchProvider(controller.text));
    return TextField(controller: controller);
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

Use for: favorites list (load from API + local toggle).

```dart
@riverpod
class Favorites extends _$Favorites {
  @override
  Future<List<Meal>> build() async {
    final repo = ref.watch(favoritesRepositoryProvider);
    return repo.getFavorites(const MealFilter());
  }

  Future<void> toggle(String mealId) async {
    final repo = ref.read(favoritesRepositoryProvider);
    final current = await future;
    final isAlready = current.any((m) => m.id == mealId);
    if (isAlready) {
      await repo.removeFavorite(mealId);
    } else {
      await repo.addFavorite(mealId);
    }
    ref.invalidateSelf(); // re-fetch from repo
  }
}
```

---

## Provider dependencies

Providers can watch other providers — they recompute automatically when a dependency changes.

```dart
@riverpod
Future<List<Meal>> filteredMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);      // service
  final filter = ref.watch(mealFilterProvider);        // user-controlled state
  return repo.getTrending(filter.toMealFilter());
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

Never use `.when()` — prefer pattern matching with `switch` for exhaustiveness checking.

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
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository.dart';
import 'package:sfrigola/repositories/meal/meal_repository_impl.dart';
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

part 'meal_provider.g.dart';
```

---

## Checklist before committing a provider

- [ ] File is in `lib/providers/` and named `*_provider.dart`
- [ ] `part '*.g.dart';` line is present
- [ ] Annotated with `@riverpod` or `@Riverpod(keepAlive: true)`
- [ ] Notifier `build()` returns the initial state / initial Future
- [ ] No `ref.watch` inside callbacks or Notifier methods (use `ref.read` there)
- [ ] `AsyncValue` is handled with `switch` covering all three cases
- [ ] Family parameters use only stable-`==` types
- [ ] `keepAlive: true` only on repository/session providers
