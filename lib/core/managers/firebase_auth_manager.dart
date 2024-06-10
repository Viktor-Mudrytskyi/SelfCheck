import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_check/core/failures/firebase_auth_failure.dart';
import 'package:self_check/core/wrappers/response_wrapper.dart';
import 'package:self_check/data/auth/models/auth_user_model.dart';

/// Singleton, class for managing low level requests with [FirebaseAuth]
final class FirebaseAuthManager {
  /// Creates instance of [FirebaseAuthManager]
  FirebaseAuthManager({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth {
    _latestState =
        FirebaseAuthUserState.fromUser(user: _firebaseAuth.currentUser);
    _streamSubscription = _firebaseAuth.authStateChanges().listen(_listener);
  }

  final StreamController<FirebaseAuthUserState> _streamController =
      StreamController<FirebaseAuthUserState>.broadcast();
  late final StreamSubscription<User?> _streamSubscription;
  final FirebaseAuth _firebaseAuth;
  late FirebaseAuthUserState _latestState;

  void _listener(User? user) {
    final FirebaseAuthUserState newState =
        FirebaseAuthUserState.fromUser(user: user);
    _latestState = newState;
    _streamController.add(newState);
  }

  /// Last recorded sauth state
  FirebaseAuthUserState get latestEvent => _latestState;

  /// [FirebaseAuthUserState] stream
  Stream<FirebaseAuthUserState> get userAuthStream => _streamController.stream;

  /// Register user, returns [UserCredential], doesn't throw
  /// [FirebaseException]
  Future<ApiResponse<UserCredential, FirebaseAuthFailure>> registerUser({
    required AuthUserModel userModel,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      return ApiResponse.success(
        credential,
      );
    } on FirebaseAuthException catch (e) {
      return ApiResponse.failure(
        FirebaseAuthFailure.fromCode(
          errorCode: e.code,
        ),
      );
    } catch (e) {
      return const ApiResponse.failure(
        UknownErrorAuthFailure(),
      );
    }
  }

  /// Sign in user, returns [UserCredential] on success, [FirebaseAuthFailure]
  /// on failure
  Future<ApiResponse<UserCredential, FirebaseAuthFailure>>
      signInWithEmailAndPassword({
    required AuthUserModel userModel,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      return ApiResponse.success(
        credential,
      );
    } on FirebaseAuthException catch (e) {
      return ApiResponse.failure(
        FirebaseAuthFailure.fromCode(
          errorCode: e.code,
        ),
      );
    } catch (e) {
      return const ApiResponse.failure(
        UknownErrorAuthFailure(),
      );
    }
  }

  /// Sign out user, throws [FirebaseException]
  Future<ApiResponse<void, FirebaseAuthFailure>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const ApiResponse.success(null);
    } on FirebaseAuthException catch (e) {
      return ApiResponse.failure(
        FirebaseAuthFailure.fromCode(
          errorCode: e.code,
        ),
      );
    } catch (e) {
      return const ApiResponse<UserCredential, FirebaseAuthFailure>.failure(
        UknownErrorAuthFailure(),
      );
    }
  }

  /// Closes [userAuthStream]
  Future<void> close() async {
    await _streamController.close();
    await _streamSubscription.cancel();
  }

  User? get user => _firebaseAuth.currentUser;
}

/// Base event for auth state changes
final class FirebaseAuthUserState {
  /// Creates instance of [FirebaseAuthUserState]
  const FirebaseAuthUserState({
    required this.user,
    required this.isSignedIn,
  });

  /// Checks the user condition
  factory FirebaseAuthUserState.fromUser({required User? user}) {
    final bool isSignedIn = user != null;
    return FirebaseAuthUserState(
      isSignedIn: isSignedIn,
      user: user,
    );
  }

  /// User instance obtained from event
  final User? user;

  /// Is user currently signed in
  final bool isSignedIn;
}
