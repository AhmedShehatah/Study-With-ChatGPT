import 'package:study_assistant_ai/core/errors/base_error.dart';

class Result<Data> {
  final Data? data;
  final BaseError? error;

  Result({this.data, this.error}) : assert(data != null || error != null);

  bool get hasDataOnly => data != null && error == null;

  bool get hasErrorOnly => data == null && error != null;

  @override
  String toString() {
    return 'Result{data: $data, error: $error}';
  }
}
