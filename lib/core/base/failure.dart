/// Base class for failures
abstract interface class Failure {
  /// Creates instance of [Failure]
  const Failure({required this.message});

  /// Failure message
  final String message;

  @override
  String toString() {
    return message;
  }
}
