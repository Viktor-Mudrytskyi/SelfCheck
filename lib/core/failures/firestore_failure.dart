// ignore_for_file: lines_longer_than_80_chars

import 'package:self_check/core/failures/failure.dart';

abstract class FirestoreFailure extends Failure {
  FirestoreFailure(this.errorCode);

  factory FirestoreFailure.fromCode(String code) {
    switch (code) {
      case 'aborted':
        return AbortedFirestoreFailure();
      case 'already-exists':
        return AlreadyExistsFirestoreFailure();
      case 'cancelled':
        return CancelledFirestoreFailure();
      case 'data-loss':
        return DataLossFirestoreFailure();
      case 'deadline-exceeded':
        return DeadlineExceededFirestoreFailure();
      case 'failed-precondition':
        return FailedPreconditionFirestoreFailure();
      case 'internal':
        return InternalFirestoreFailure();
      case 'invalid-argument':
        return InvalidArgumentFirestoreFailure();
      case 'not-found':
        return NotFoundFirestoreFailure();
      case 'out-of-range':
        return OutOfRangeFirestoreFailure();
      case 'permission-denied':
        return PermissionDeniedFirestoreFailure();
      case 'resource-exhausted':
        return ResourceExhaustedFirestoreFailure();
      case 'unauthenticated':
        return UnauthenticatedFirestoreFailure();
      case 'unavailable':
        return UnavailableFirestoreFailure();
      case 'unimplemented':
        return UnimplementedFirestoreFailure();
      case 'unknown':
        return UnknownFirestoreFailure();
      default:
        return UnknownFirestoreFailure();
    }
  }
  final String errorCode;
}

class AbortedFirestoreFailure extends FirestoreFailure {
  AbortedFirestoreFailure() : super('aborted');

  @override
  String get message =>
      'The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.';
}

class AlreadyExistsFirestoreFailure extends FirestoreFailure {
  AlreadyExistsFirestoreFailure() : super('already-exists');

  @override
  String get message =>
      'Some document that we attempted to create already exists.';
}

class CancelledFirestoreFailure extends FirestoreFailure {
  CancelledFirestoreFailure() : super('cancelled');

  @override
  String get message =>
      'The operation was cancelled (typically by the caller).';
}

class DataLossFirestoreFailure extends FirestoreFailure {
  DataLossFirestoreFailure() : super('data-loss');

  @override
  String get message => 'Unrecoverable data loss or corruption.';
}

class DeadlineExceededFirestoreFailure extends FirestoreFailure {
  DeadlineExceededFirestoreFailure() : super('deadline-exceeded');

  @override
  String get message => 'Deadline expired before operation could complete.';
}

class FailedPreconditionFirestoreFailure extends FirestoreFailure {
  FailedPreconditionFirestoreFailure() : super('failed-precondition');

  @override
  String get message =>
      'Operation was rejected because the system is not in a state required for the operation\'s execution.';
}

class InternalFirestoreFailure extends FirestoreFailure {
  InternalFirestoreFailure() : super('internal');

  @override
  String get message => 'Internal errors.';
}

class InvalidArgumentFirestoreFailure extends FirestoreFailure {
  InvalidArgumentFirestoreFailure() : super('invalid-argument');

  @override
  String get message => 'Client specified an invalid argument.';
}

class NotFoundFirestoreFailure extends FirestoreFailure {
  NotFoundFirestoreFailure() : super('not-found');

  @override
  String get message => 'Some requested document was not found.';
}

class OutOfRangeFirestoreFailure extends FirestoreFailure {
  OutOfRangeFirestoreFailure() : super('out-of-range');

  @override
  String get message => 'Operation was attempted past the valid range.';
}

class PermissionDeniedFirestoreFailure extends FirestoreFailure {
  PermissionDeniedFirestoreFailure() : super('permission-denied');

  @override
  String get message =>
      'The caller does not have permission to execute the specified operation.';
}

class ResourceExhaustedFirestoreFailure extends FirestoreFailure {
  ResourceExhaustedFirestoreFailure() : super('resource-exhausted');

  @override
  String get message =>
      'Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.';
}

class UnauthenticatedFirestoreFailure extends FirestoreFailure {
  UnauthenticatedFirestoreFailure() : super('unauthenticated');

  @override
  String get message =>
      'The request does not have valid authentication credentials for the operation.';
}

class UnavailableFirestoreFailure extends FirestoreFailure {
  UnavailableFirestoreFailure() : super('unavailable');

  @override
  String get message => 'The service is currently unavailable.';
}

class UnimplementedFirestoreFailure extends FirestoreFailure {
  UnimplementedFirestoreFailure() : super('unimplemented');

  @override
  String get message =>
      'Operation is not implemented or not supported/enabled.';
}

class UnknownFirestoreFailure extends FirestoreFailure {
  UnknownFirestoreFailure() : super('unknown');

  @override
  String get message =>
      'Unknown error or an error from a different error domain.';
}
