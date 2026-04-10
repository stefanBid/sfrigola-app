// ---------------------------------------------------------------------------
// Meal domain
// ---------------------------------------------------------------------------

class MealNotFoundException implements Exception {
  const MealNotFoundException(this.id);
  final String id;

  @override
  String toString() => 'MealNotFoundException: no meal found with id "$id"';
}
