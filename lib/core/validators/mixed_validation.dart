import 'package:study_assistant_ai/core/validators/required_validator.dart';

import 'base_validator.dart';

String? conditionalValidator(String? value, BaseValidator validator) {
  /*
  For required filed in addition to their own type of validation
   */
  if (value!.isEmpty) {
    return RequiredValidator().getMessage();
  }
  return validator.validate(value) ? null : validator.getMessage();
}
