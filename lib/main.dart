import 'package:flutter/material.dart';

void main() {
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
