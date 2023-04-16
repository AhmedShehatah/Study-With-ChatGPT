import '../validators/base_validator.dart';

class PasswordValidator extends BaseValidator {
  @override
  String getMessage() {
    return 'password must be at least 8 characters';
  }

  @override
  bool validate(String? value) {
    return value != null && value.length >= 8;
  }
}
