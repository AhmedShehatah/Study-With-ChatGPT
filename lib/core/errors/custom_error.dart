// ignore_for_file: overridden_fields

import 'base_error.dart';

class CustomError extends BaseError {
  @override
  final String? message;
  final int? statusCode;

  CustomError({
    this.message,
    this.statusCode,
  }) : super(message);
}
