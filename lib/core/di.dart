import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:self_check/core/managers/firebase_auth_manager.dart';

/// Global di injector of [GetIt]
final GetIt getIt = GetIt.instance;

/// Init [GetIt] injector
Future<void> initDI() async {
  getIt.registerLazySingleton(
    () => FirebaseAuthManager(firebaseAuth: FirebaseAuth.instance),
  );
}
