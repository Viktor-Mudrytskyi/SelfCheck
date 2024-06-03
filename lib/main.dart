import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:self_check/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'dasd',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

/// Main Application
class MainApp extends StatelessWidget {
  /// Creates an instance of [MainApp]
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
