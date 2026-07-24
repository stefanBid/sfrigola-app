// Project Models
import 'package:sfrigola/core/models/language.dart';

abstract interface class LanguageRepository {
  Future<List<Language>> getLanguages({bool? isActive});
}
