/// A class that allows to wrap responses such as API.
class ResponseWrapper<Success, Failure> {
  /// Creates an instance of successful [ResponseWrapper]
  const ResponseWrapper.success(Success this.data)
      : failure = null,
        isSuccessful = true;

  /// Creates an instance of failed [ResponseWrapper]
  const ResponseWrapper.failure(Failure this.failure)
      : data = null,
        isSuccessful = false;

  /// Success state
  final Success? data;

  /// Failure state
  final Failure? failure;

  /// If response is successful
  final bool isSuccessful;

  /// Exhaustive matching
  T fold<T>({
    required T Function(Success success) success,
    required T Function(Failure failure) failure,
  }) {
    if (isSuccessful) {
      return success(this.data as Success);
    } else {
      return failure(this.failure as Failure);
    }
  }

  @override
  String toString() {
    final String part1 = isSuccessful ? 'Success: ' : 'Failure: ';
    final String part2 = isSuccessful ? data.toString() : failure.toString();

    return '$part1 $part2';
  }
}
