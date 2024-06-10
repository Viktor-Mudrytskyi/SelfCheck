import 'package:self_check/core/failures/failure.dart';

/// Firebase auth base failure
abstract base class FirebaseAuthFailure implements Failure {
  /// Base constructor for [FirebaseAuthFailure]
  const FirebaseAuthFailure({required this.errorCode});

  /// Gets failure corresponding to the code
  factory FirebaseAuthFailure.fromCode({required String errorCode}) {
    return switch (errorCode) {
      'invalid-credential' => WrongPasswordAuthFailure(errorCode: errorCode),
      'wrong-password' => WrongPasswordAuthFailure(errorCode: errorCode),
      'invalid-email' => InvalidEmailAuthFailure(errorCode: errorCode),
      'user-disabled' => UserDisabledAuthFailure(errorCode: errorCode),
      'user-not-found' => UserNotFoundAuthFailure(errorCode: errorCode),
      'email-already-in-use' =>
        EmailAlreadyInUseAuthFailure(errorCode: errorCode),
      'operation-not-allowed' =>
        OperationNotAllowedUseAuthFailure(errorCode: errorCode),
      'weak-password' => WrongPasswordAuthFailure(errorCode: errorCode),
      String() => const UknownErrorAuthFailure(),
    };
  }

  /// Error code from api
  final String errorCode;
}

/// Wrong password
final class WrongPasswordAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [WrongPasswordAuthFailure]
  const WrongPasswordAuthFailure({required super.errorCode});

  @override
  String get message => 'Wrong password';
}

/// Invalid email
final class InvalidEmailAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [InvalidEmailAuthFailure]
  const InvalidEmailAuthFailure({required super.errorCode});

  @override
  String get message => 'Invalid email';
}

/// User disabled
final class UserDisabledAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [UserDisabledAuthFailure]
  const UserDisabledAuthFailure({required super.errorCode});

  @override
  String get message => 'User disabled';
}

/// User not found
final class UserNotFoundAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [UserNotFoundAuthFailure]
  const UserNotFoundAuthFailure({required super.errorCode});

  @override
  String get message => 'User not found';
}

/// Email already in use
final class EmailAlreadyInUseAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [EmailAlreadyInUseAuthFailure]
  const EmailAlreadyInUseAuthFailure({required super.errorCode});

  @override
  String get message => 'Email already in use';
}

/// Operation not allowed
final class OperationNotAllowedUseAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [OperationNotAllowedUseAuthFailure]
  const OperationNotAllowedUseAuthFailure({required super.errorCode});

  @override
  String get message => 'Operation not allowed';
}

/// Weak password
final class WeakPasswordAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [WeakPasswordAuthFailure]
  const WeakPasswordAuthFailure({required super.errorCode});

  @override
  String get message => 'Weak password';
}

/// Unknown error
final class UknownErrorAuthFailure extends FirebaseAuthFailure {
  /// Creates instance of [UknownErrorAuthFailure]
  const UknownErrorAuthFailure({super.errorCode = ''});

  @override
  String get message => 'Unknown error';
}
