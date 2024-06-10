import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/core/failures/failure.dart';
import 'package:self_check/core/failures/firebase_auth_failure.dart';
import 'package:self_check/core/managers/firebase_auth_manager.dart';
import 'package:self_check/core/validation/basic/email_validator.dart';
import 'package:self_check/core/validation/basic/password_validator.dart';
import 'package:self_check/core/wrappers/response_wrapper.dart';
import 'package:self_check/data/auth/models/auth_user_model.dart';

part 'auth_state.dart';

/// [Cubit] responsible for loggin in and registration
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required FirebaseAuthManager authRepository})
      : _authRepository = authRepository,
        super(LoadedAuthState.getInitial());
  final FirebaseAuthManager _authRepository;

  Future<void> onChangeEmail(String newEmail) async {
    state.mapOrNull(
      loaded: (LoadedAuthState authLoadedState) {
        authLoadedState.emailValidator.update(newEmail);
        emit(authLoadedState.copyWith(email: newEmail));
      },
    );
  }

  Future<void> onChangePassword(String newPassword) async {
    state.mapOrNull(
      loaded: (LoadedAuthState authLoadedState) {
        authLoadedState.passwordValidator.update(newPassword);
        emit(authLoadedState.copyWith(password: newPassword));
      },
    );
  }

  Future<void> onRegister() async {
    return state.mapOrNull(
      loaded: (LoadedAuthState authLoadedState) async {
        if (!_checkValidity()) {
          emit(authLoadedState.copyWith(shouldShowError: true));
          return;
        }

        emit(authLoadedState.copyWith(showScreenLoader: true));

        final ApiResponse<UserCredential, FirebaseAuthFailure> registerResult =
            await _authRepository.registerUser(
          userModel: AuthUserModel(
            email: authLoadedState.email,
            password: authLoadedState.password,
          ),
        );
        registerResult.fold(
          success: (_) => emit(const SuccessAuthState()),
          failure: (FirebaseAuthFailure failure) {
            emit(
              ErrorAuthState(failure: failure),
            );
            emit(authLoadedState);
          },
        );
      },
    );
  }

  Future<void> onSignIn() async {
    return state.mapOrNull(
      loaded: (LoadedAuthState authLoadedState) async {
        if (!_checkValidity()) {
          emit(authLoadedState.copyWith(shouldShowError: true));
          return;
        }

        emit(authLoadedState.copyWith(showScreenLoader: true));

        final ApiResponse<UserCredential, FirebaseAuthFailure> registerResult =
            await _authRepository.signInWithEmailAndPassword(
          userModel: AuthUserModel(
            email: authLoadedState.email,
            password: authLoadedState.password,
          ),
        );
        registerResult.fold(
          success: (_) => emit(const SuccessAuthState()),
          failure: (FirebaseAuthFailure failure) {
            emit(
              ErrorAuthState(failure: failure),
            );
            emit(authLoadedState);
          },
        );
      },
    );
  }

  /// If email and password fields are valid
  bool _checkValidity() {
    return state.maybeMap(
      orElse: () => false,
      loaded: (LoadedAuthState authLoadedState) =>
          authLoadedState.emailValidator.isValid &&
          authLoadedState.passwordValidator.isValid,
    );
  }
}
