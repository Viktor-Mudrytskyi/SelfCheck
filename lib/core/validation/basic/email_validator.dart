import 'package:self_check/core/extensions.dart';
import 'package:self_check/core/failures/email_failure.dart';
import 'package:self_check/core/validation/validator.dart';

class EmailValidator extends BaseValidator<String?, EmailFailure> {
  EmailValidator(super.value);

  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  EmailFailure? validate(String? value) {
    if (value.isNullOrEmpty) return EmailEmptyFailure();
    if (value!.trim().isEmpty) return EmailEmptyFailure();
    if (!_emailRegExp.hasMatch(value)) {
      return EmailInvalidFailure();
    }

    return null;
  }
}
