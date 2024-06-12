import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:self_check/core/managers/firebase_auth_manager.dart';
import 'package:self_check/core/managers/firestore_manager.dart';
import 'package:self_check/presentation/auth/bloc/auth_cubit/auth_cubit.dart';
import 'package:self_check/presentation/home/bloc/user_cubit/user_cubit.dart';

/// Global di injector of [GetIt]
final GetIt getIt = GetIt.instance;

/// Init [GetIt] injector
Future<void> initDI() async {
  /// Managers
  getIt.registerLazySingleton(
    () => FirebaseAuthManager(firebaseAuth: FirebaseAuth.instance),
  );
  getIt.registerLazySingleton(
    () => FirestoreManager(firestore: FirebaseFirestore.instance),
  );

  /// Bloc
  getIt.registerFactory(() => AuthCubit(authRepository: getIt()));
  getIt.registerFactory(() => UserCubit(firebaseAuthManager: getIt()));
}
