import 'package:sfrigola/core/models/be-models/be_error.dart';

class GetDataResponse<T> {
  final T data;
  final BeError? error;

  GetDataResponse({required this.data, this.error});
}

class GetListDataResponse<T> {
  final List<T> data;
  final int total;
  final BeError? error;

  GetListDataResponse({required this.data, required this.total, this.error});
}
