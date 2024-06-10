import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';

/// Primary app button
class SecondaryButton extends StatelessWidget {
  /// Creates instance of [SecondaryButton]
  const SecondaryButton({
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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1,
              minimumSize: Size(
                constr.maxWidth,
                height,
              ),
              side: BorderSide(color: context.theme.primaryColor),
            ),
            onPressed: enabled ? onPressed : null,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade700,
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
