import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_check/presentation/basic/loaders/app_loader.dart';

class StackedLoader extends StatelessWidget {
  const StackedLoader({
    required this.isLoading,
    required this.child,
    super.key,
  });
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            child,
            if (isLoading)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withOpacity(.2),
                ),
              ),
          ],
        ),
        if (isLoading)
          const Positioned.fill(
            child: AppLoader(
              radius: 20,
            ),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
  }
}
