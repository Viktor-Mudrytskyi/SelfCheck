import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({
    required this.icon,
    required this.animationController,
    required this.onPressed,
    super.key,
  });
  final Icon icon;
  final AnimationController animationController;
  final void Function() onPressed;

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<AnimationController>(
        'animationController',
        animationController,
      ),
    );
    properties
        .add(ObjectFlagProperty<void Function()>.has('onPressed', onPressed));
  }
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation;

  @override
  void initState() {
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.easeInCirc,
      ),
    );
    super.initState();
  }

  void _toggle() => widget.animationController.isCompleted
      ? widget.animationController.reverse()
      : widget.animationController.forward();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          widget.onPressed();
          _toggle();
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.theme.secondaryHeaderColor,
          ),
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: widget.animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: math.pi * 1.25 * _animation.value,
                child: widget.icon,
              );
            },
          ),
        ),
      ),
    );
  }
}
