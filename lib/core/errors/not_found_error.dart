import './base_error.dart';

class NotFoundError extends BaseError {
  NotFoundError({String? message}) : super(message ?? "Not Found");
}
