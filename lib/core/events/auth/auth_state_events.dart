import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_check/core/base/event.dart';

/// Base event for auth state changes
final class AuthState extends State {
  /// Creates instance of [AuthState]
  const AuthState({
    required this.user,
    required this.isSignedIn,
  });

  /// Checks the user condition
  factory AuthState.fromUser({required User? user}) {
    final bool isSignedIn = user != null;
    return AuthState(
      isSignedIn: isSignedIn,
      user: user,
    );
  }

  /// User instance obtained from event
  final User? user;

  /// Is user currently signed in
  final bool isSignedIn;
}
