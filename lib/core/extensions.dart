import 'package:flutter/material.dart';

/// Utils for faster work
extension ContextUtils on BuildContext {
  /// Shows whether [Directionality.of(this)] is left to right
  bool get isLtr => Directionality.of(this) == TextDirection.ltr;

  /// Proper focus removal
  void removeFocus() {
    final FocusScopeNode currentScope = FocusScope.of(this);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Gets render box if [RenderObject] is not null and is [RenderBox]
  RenderBox? get renderBox {
    final RenderObject? box = findRenderObject();

    if (box == null || box is! RenderBox) {
      return null;
    }
    return box;
  }

  ThemeData get theme => Theme.of(this);

  /// Get padding of this from nearest [MediaQuery]
  EdgeInsets get systemPadding => MediaQuery.paddingOf(this);

  /// Get [Size] of [MediaQuery]
  Size get size => MediaQuery.sizeOf(this);

  void showSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: theme.primaryColor,
      ),
    );
  }
}

/// Utils for faster null or empty checks
extension NullOrEmptyString on String? {
  /// Checks whether this string is null or empty
  bool get isNullOrEmpty {
    return (this ?? '').isEmpty;
  }

  /// Checks whether this string is not null or empty
  bool get isNotNullOrEmpty {
    return (this ?? '').isNotEmpty;
  }
}
