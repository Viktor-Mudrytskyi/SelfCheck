import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';

/// Primary app button
class PrimaryButton extends StatelessWidget {
  /// Creates instance of [PrimaryButton]
  const PrimaryButton({
    required this.title,
    this.enabled = true,
    this.onPressed,
    super.key,
    this.height = _defaultHeight,
  });

  /// Button title
  final String title;

  /// Height of a button
  final double height;

  /// On pressed trigger
  final void Function()? onPressed;

  /// If [onPressed] is null the button is disabled despite [enabled] parametr
  final bool enabled;

  static const double _defaultHeight = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constr) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.theme.primaryColor,
              overlayColor: Colors.white,
              elevation: 1,
              minimumSize: Size(
                constr.maxWidth,
                height,
              ),
            ),
            onPressed: enabled ? onPressed : null,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<void Function()>.has('onPressed', onPressed))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DoubleProperty('height', height));
  }
}
