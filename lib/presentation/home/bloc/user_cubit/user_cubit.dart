import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/core/managers/firebase_auth_manager.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required FirebaseAuthManager firebaseAuthManager})
      : _firebaseAuthManager = firebaseAuthManager,
        super(LoadingUserState()) {
    _userAuthStateSubscribtion =
        _firebaseAuthManager.userAuthStream.listen(_authChangeListener);
  }

  late final StreamSubscription<FirebaseAuthUserState>
      _userAuthStateSubscribtion;

  final FirebaseAuthManager _firebaseAuthManager;

  void _authChangeListener(FirebaseAuthUserState userAuthState) {
    if (userAuthState.isSignedIn) {
      emit(AuthenticatedUserState(user: userAuthState.user!));
      return;
    }

    emit(UnauthenticatedUserState());
  }

  Future<void> signOut() async {
    final res = await _firebaseAuthManager.signOut();
    res.fold(
      success: (_) => UnauthenticatedUserState(),
      failure: (_) => AuthenticatedUserState(user: _firebaseAuthManager.user!),
    );
  }

  @override
  Future<void> close() {
    _userAuthStateSubscribtion.cancel();
    return super.close();
  }
}
