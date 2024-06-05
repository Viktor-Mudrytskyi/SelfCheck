import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_check/core/managers/firebase_auth_manager.dart';
import 'package:self_check/core/wrappers/response_wrapper.dart';
import 'package:self_check/data/auth/failures/firebase_auth_failure.dart';
import 'package:self_check/data/auth/models/auth_user_model.dart';

/// Repository responsible for connecting UI and api
final class AuthRepository {
  /// Creaates instance of [AuthRepository]
  const AuthRepository({required FirebaseAuthManager firebaseAuthManager})
      : _firebaseAuthManager = firebaseAuthManager;

  final FirebaseAuthManager _firebaseAuthManager;

  /// Register user
  Future<ResponseWrapper<UserCredential, FirebaseAuthFailure>> registerUser({
    required AuthUserModel userModel,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuthManager.registerUser(userModel: userModel);
      return ResponseWrapper<UserCredential, FirebaseAuthFailure>.success(
        credential,
      );
    } on FirebaseAuthException catch (e) {
      return ResponseWrapper<UserCredential, FirebaseAuthFailure>.failure(
        FirebaseAuthFailure.fromCode(
          errorCode: e.code,
        ),
      );
    } catch (e) {
      return const ResponseWrapper<UserCredential, FirebaseAuthFailure>.failure(
        UknownErrorAuthFailure(),
      );
    }
  }

  /// Sign in user
  Future<ResponseWrapper<UserCredential, FirebaseAuthFailure>> signInUser({
    required AuthUserModel userModel,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuthManager
          .signInWithEmailAndPassword(userModel: userModel);
      return ResponseWrapper<UserCredential, FirebaseAuthFailure>.success(
        credential,
      );
    } on FirebaseAuthException catch (e) {
      return ResponseWrapper<UserCredential, FirebaseAuthFailure>.failure(
        FirebaseAuthFailure.fromCode(
          errorCode: e.code,
        ),
      );
    } catch (e) {
      return const ResponseWrapper<UserCredential, FirebaseAuthFailure>.failure(
        UknownErrorAuthFailure(),
      );
    }
  }

  /// Log out user
  Future<ResponseWrapper<void, FirebaseAuthFailure>> logOutUser({
    required AuthUserModel userModel,
  }) async {
    try {
      await _firebaseAuthManager.signOut();
      return const ResponseWrapper<void, FirebaseAuthFailure>.success(null);
    } on FirebaseAuthException catch (e) {
      return ResponseWrapper<UserCredential, FirebaseAuthFailure>.failure(
        FirebaseAuthFailure.fromCode(
          errorCode: e.code,
        ),
      );
    } catch (e) {
      return const ResponseWrapper<UserCredential, FirebaseAuthFailure>.failure(
        UknownErrorAuthFailure(),
      );
    }
  }
}
