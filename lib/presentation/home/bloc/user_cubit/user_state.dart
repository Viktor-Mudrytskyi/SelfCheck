part of 'user_cubit.dart';

@immutable
sealed class UserState {
  /// Exhaustive matching
  T map<T>({
    required T Function(
      LoadingUserState loading,
    ) loading,
    required T Function(
      AuthenticatedUserState authenticated,
    ) authenticated,
    required T Function(
      UnauthenticatedUserState unauthenticated,
    ) unauthenticated,
  }) {
    return switch (this) {
      LoadingUserState() => loading(
          this as LoadingUserState,
        ),
      AuthenticatedUserState() => authenticated(
          this as AuthenticatedUserState,
        ),
      UnauthenticatedUserState() => unauthenticated(
          this as UnauthenticatedUserState,
        ),
    };
  }

  /// Match or else
  T maybeMap<T>({
    required T Function() orElse,
    T Function(
      LoadingUserState loading,
    )? loading,
    T Function(
      AuthenticatedUserState authenticated,
    )? authenticated,
    T Function(
      UnauthenticatedUserState unauthenticated,
    )? unauthenticated,
  }) {
    return switch (this) {
      LoadingUserState() => loading != null
          ? loading(
              this as LoadingUserState,
            )
          : orElse(),
      AuthenticatedUserState() => authenticated != null
          ? authenticated(
              this as AuthenticatedUserState,
            )
          : orElse(),
      UnauthenticatedUserState() => unauthenticated != null
          ? unauthenticated(
              this as UnauthenticatedUserState,
            )
          : orElse(),
    };
  }

  /// Match or null
  T? mapOrNull<T>({
    T Function(
      LoadingUserState loading,
    )? loading,
    T Function(
      AuthenticatedUserState authenticated,
    )? authenticated,
    T Function(
      UnauthenticatedUserState unauthenticated,
    )? unauthenticated,
  }) {
    return switch (this) {
      LoadingUserState() => loading != null
          ? loading(
              this as LoadingUserState,
            )
          : null,
      AuthenticatedUserState() => authenticated != null
          ? authenticated(
              this as AuthenticatedUserState,
            )
          : null,
      UnauthenticatedUserState() => unauthenticated != null
          ? unauthenticated(
              this as UnauthenticatedUserState,
            )
          : null,
    };
  }
}

final class LoadingUserState extends UserState {}

final class AuthenticatedUserState extends UserState {
  AuthenticatedUserState({required this.user});

  final User user;
}

final class UnauthenticatedUserState extends UserState {}
