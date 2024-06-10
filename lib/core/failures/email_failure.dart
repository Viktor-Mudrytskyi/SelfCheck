import 'package:self_check/core/failures/failure.dart';

sealed class EmailFailure implements Failure {
  const EmailFailure();
}

final class EmailEmptyFailure extends EmailFailure {
  @override
  String get message => 'Email empty';
}

final class EmailInvalidFailure extends EmailFailure {
  @override
  String get message => 'Invalid email';
}
