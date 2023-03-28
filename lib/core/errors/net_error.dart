import '../../../core/errors/base_error.dart';

class NetError extends BaseError {
  NetError({String? message}) : super(message ?? "Connection Error");
}
