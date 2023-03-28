import './base_error.dart';

class UnauthorizedError extends BaseError {
  UnauthorizedError({String? message}) : super(message ?? "Unauthorized Error");
}
