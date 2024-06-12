import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';

/// A scaffold with body that removes focus on tap
class RemoveFocusScaffold extends StatelessWidget {
  /// Creates instance of [RemoveFocusScaffold]
  const RemoveFocusScaffold({
    super.key,
    this.body,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
  });

  /// Standart [Scaffold] body
  final Widget? body;

  /// Standart [Scaffold] appBar
  final PreferredSizeWidget? appBar;

  final Widget? drawer;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.removeFocus,
      child: Scaffold(
        body: body,
        drawer: drawer,
        appBar: appBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
