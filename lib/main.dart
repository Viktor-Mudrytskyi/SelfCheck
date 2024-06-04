import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:self_check/core/di.dart';
import 'package:self_check/firebase_options.dart';
import 'package:self_check/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await Firebase.initializeApp(
    name: 'SelfCheck',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}
