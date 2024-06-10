import 'package:flutter/material.dart';

/// Data class for theme
final class CustomThemeData {
  ThemeData get customTheme => ThemeData.light().copyWith(
        primaryColor: Colors.indigo,
      );
}
