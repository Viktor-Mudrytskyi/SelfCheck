import 'package:self_check/core/failures/failure.dart';

abstract class PasswordFailure extends Failure {
  const PasswordFailure();
}

final class PasswordEmptyFailure extends PasswordFailure {
  @override
  String get message => 'Password is empty';
}

final class PasswordTooShortFailure extends PasswordFailure {
  @override
  String get message => 'Password is too short';
}
