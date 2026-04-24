// Project Models
import 'package:sfrigola/core/models/be-models/be_error.dart';

/// Response model for mutation endpoints — POST, PUT, PATCH, DELETE.
///
/// The BE always returns a body with [success] and an optional [error].
/// When [error] is non-null, [success] is false and the repository throws.
class MutationResponse {
  final bool success;
  final BeError? error;

  const MutationResponse({required this.success, this.error});
}
