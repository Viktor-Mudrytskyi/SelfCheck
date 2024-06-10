/// Base class for failures
abstract class Failure {
  /// Creates instance of [Failure]
  const Failure();

  /// Failure message
  String get message;

  @override
  String toString() {
    return message;
  }
}
