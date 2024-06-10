import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/core/di.dart';
import 'package:self_check/presentation/home/bloc/user_cubit/user_cubit.dart';
import 'package:self_check/presentation/home/screens/home_screen.dart';
import 'package:self_check/presentation/theme/colors_theme_data.dart';

/// Main Application
class MainApp extends StatelessWidget {
  /// Creates an instance of [MainApp]
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomThemeData().customTheme,
      home: const HomeScreen(),
      builder: (context, child) {
        return BlocProvider<UserCubit>(
          create: (context) => getIt(),
          child: child,
        );
      },
    );
  }
}
