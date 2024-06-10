import 'package:self_check/core/extensions.dart';
import 'package:self_check/core/failures/password_failure.dart';
import 'package:self_check/core/validation/validator.dart';

class PasswordValidator extends BaseValidator<String, PasswordFailure> {
  PasswordValidator(super.value);

  @override
  PasswordFailure? validate(String value) {
    if (value.isNullOrEmpty) {
      return PasswordEmptyFailure();
    }

    if (value.length < 6) {
      return PasswordTooShortFailure();
    }
    return null;
  }
}
