import 'dart:async';

/// Abstract validator class with async validation
abstract class BaseAsyncValidator<Value, Failure> {
  /// Use [update] after calling [BaseAsyncValidator] to validate a
  /// s constructors cannot be async
  BaseAsyncValidator();

  /// Call update to update all fields of the validator, [validate]
  /// is called automatically
  FutureOr<void> update(Value value) async {
    _value = value;
    _failure = await validate(value);
  }

  /// DOES NOT update any field in a validator, only returns a failure, to
  /// update the validator instance call [update]
  FutureOr<Failure>? validate(Value value);

  Failure? _failure;
  late Value _value;

  /// [Value] provided last
  Value get value => _value;

  /// Possible current [Failure]
  Failure? get failure => _failure;

  /// Is validated succesfully
  bool get isValid => _failure == null;
}
