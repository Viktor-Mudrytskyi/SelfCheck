import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';
import 'package:self_check/presentation/basic/custom_animated_icon.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({required this.onTap, super.key});
  final void Function() onTap;

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<void Function()>.has('onTap', onTap));
  }
}

class _CustomFloatingButtonState extends State<CustomFloatingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
      onPressed: () {},
      icon: Icon(
        Icons.add,
        color: context.theme.primaryColor,
        size: 26,
      ),
      animationController: _animationController,
    );
  }
}
