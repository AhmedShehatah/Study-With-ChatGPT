import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String getMessage() {
    // return translate('v_required');
    return 'required';
  }

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty;
  }
}
