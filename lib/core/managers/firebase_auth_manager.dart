import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_check/core/events/auth/auth_state_events.dart';
import 'package:self_check/data/auth/models/auth_user_model.dart';

/// Singleton, class for managing low level requests with [FirebaseAuth]
final class FirebaseAuthManager {
  /// Creates instance of [FirebaseAuthManager]
  FirebaseAuthManager({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth {
    _latestState = AuthState.fromUser(user: _firebaseAuth.currentUser);
    _streamSubscription = _firebaseAuth.authStateChanges().listen(_listener);
  }

  final StreamController<AuthState> _streamController =
      StreamController<AuthState>.broadcast();
  late final StreamSubscription<User?> _streamSubscription;
  final FirebaseAuth _firebaseAuth;
  late AuthState _latestState;

  void _listener(User? user) {
    final AuthState newState = AuthState.fromUser(user: user);
    _latestState = newState;
    _streamController.add(newState);
  }

  /// Last recorded sauth state
  AuthState get latestEvent => _latestState;

  /// [AuthState] stream
  Stream<AuthState> get stream => _streamController.stream;

  /// Register user, returns [UserCredential], throws [FirebaseException]
  Future<UserCredential> registerUser({
    required AuthUserModel userModel,
  }) async {
    final UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password,
    );
    return credential;
  }

  /// Sign in user, returns [UserCredential], throws [FirebaseException]
  Future<UserCredential> signInWithEmailAndPassword({
    required AuthUserModel userModel,
  }) async {
    final UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password,
    );
    return credential;
  }

  /// Sign out user, throws [FirebaseException]
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  /// Closes [stream]
  Future<void> close() async {
    await _streamController.close();
    await _streamSubscription.cancel();
  }
}
