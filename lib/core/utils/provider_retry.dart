import 'package:sfrigola/core/models/general_exception.dart';

Duration? appRetry(int retryCount, Object error) {
  if (retryCount >= 2) return null;
  if (error is AppException) {
    return error.isRetryable ? Duration(seconds: retryCount + 1) : null;
  }
  return null;
}
