import '../validators/base_validator.dart';

class PhoneValidator extends BaseValidator {
  @override
  String getMessage() {
    return 'invalid phone number';
  }

  @override
  bool validate(String? value) {
    final regex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    return regex.hasMatch(value!) && value.length > 5;
  }
}
