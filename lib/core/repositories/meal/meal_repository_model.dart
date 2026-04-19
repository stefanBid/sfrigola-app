// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

// Project Models
import 'package:sfrigola/core/models/general_exception.dart';

// ---------------------------------------------------------------------------
// Meal domain
// ---------------------------------------------------------------------------

class MealNotFoundException implements AppException {
  const MealNotFoundException(this.id);
  final String id;

  @override
  bool get isRetryable => false;

  @override
  String localizedMessage(AppLocalizations l) => l.mealNotFoundError;

  @override
  String toString() => 'MealNotFoundException: no meal found with id "$id"';
}
