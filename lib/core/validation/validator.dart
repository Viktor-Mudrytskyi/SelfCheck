/// Abstract validator class
abstract class BaseValidator<Value, Failure> {
  /// Creates instance of [BaseValidator]. Calls [update] with [value]
  BaseValidator(Value value) {
    update(value);
  }

  /// Call update to update all fields of the validator, [validate]
  /// is called automatically
  void update(Value value) {
    _value = value;
    _failure = validate(value);
  }

  /// DOES NOT update any field in a validator, only returns a failure,
  /// to update the validator instance call [update]
  Failure? validate(Value value);

  Failure? _failure;
  late Value _value;

  /// [Value] provided last

  Value get value => _value;

  /// Possible current [Failure]

  Failure? get failure => _failure;

  /// Is validated succesfully

  bool get isValid => _failure == null;
}
