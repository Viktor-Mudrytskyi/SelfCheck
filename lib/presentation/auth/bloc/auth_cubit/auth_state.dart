part of 'auth_cubit.dart';

/// [State] responsible for tracking loggin and registration states
@immutable
sealed class AuthState {
  const AuthState();

  /// Exhaustive matching
  T map<T>({
    required T Function(
      LoadedAuthState loaded,
    ) loaded,
    required T Function(
      ErrorAuthState error,
    ) error,
    required T Function(
      SuccessAuthState success,
    ) success,
  }) {
    return switch (this) {
      LoadedAuthState() => loaded(
          this as LoadedAuthState,
        ),
      ErrorAuthState() => error(
          this as ErrorAuthState,
        ),
      SuccessAuthState() => success(
          this as SuccessAuthState,
        ),
    };
  }

  /// Match or else
  T maybeMap<T>({
    required T Function() orElse,
    T Function(
      LoadedAuthState loaded,
    )? loaded,
    T Function(
      ErrorAuthState error,
    )? error,
    T Function(
      SuccessAuthState success,
    )? success,
  }) {
    return switch (this) {
      LoadedAuthState() => loaded != null
          ? loaded(
              this as LoadedAuthState,
            )
          : orElse(),
      ErrorAuthState() => error != null
          ? error(
              this as ErrorAuthState,
            )
          : orElse(),
      SuccessAuthState() => success != null
          ? success(
              this as SuccessAuthState,
            )
          : orElse(),
    };
  }

  /// Match or null
  T? mapOrNull<T>({
    T Function(
      LoadedAuthState loaded,
    )? loaded,
    T Function(
      ErrorAuthState error,
    )? error,
    T Function(
      SuccessAuthState success,
    )? success,
  }) {
    return switch (this) {
      LoadedAuthState() => loaded != null
          ? loaded(
              this as LoadedAuthState,
            )
          : null,
      ErrorAuthState() => error != null
          ? error(
              this as ErrorAuthState,
            )
          : null,
      SuccessAuthState() => success != null
          ? success(
              this as SuccessAuthState,
            )
          : null,
    };
  }
}

/// [AuthState] after the data is set up
class LoadedAuthState extends AuthState {
  const LoadedAuthState({
    required this.email,
    required this.password,
    required this.emailValidator,
    required this.passwordValidator,
    required this.showScreenLoader,
    required this.shouldShowError,
  });

  factory LoadedAuthState.getInitial() {
    return LoadedAuthState(
      email: '',
      password: '',
      emailValidator: EmailValidator(''),
      passwordValidator: PasswordValidator(''),
      showScreenLoader: false,
      shouldShowError: false,
    );
  }

  final String email;
  final String password;
  final EmailValidator emailValidator;
  final PasswordValidator passwordValidator;
  final bool showScreenLoader;
  final bool shouldShowError;

  LoadedAuthState copyWith({
    String? email,
    String? password,
    EmailValidator? emailValidator,
    PasswordValidator? passwordValidator,
    bool? showScreenLoader,
    bool? shouldShowError,
  }) {
    return LoadedAuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValidator: emailValidator ?? this.emailValidator,
      passwordValidator: passwordValidator ?? this.passwordValidator,
      showScreenLoader: showScreenLoader ?? this.showScreenLoader,
      shouldShowError: shouldShowError ?? this.shouldShowError,
    );
  }
}

/// [AuthState] for api errors
final class ErrorAuthState extends AuthState {
  const ErrorAuthState({required this.failure});

  final Failure failure;
}

/// [AuthState] signaling for successful authentication
final class SuccessAuthState extends AuthState {
  const SuccessAuthState();
}
