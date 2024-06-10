import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';

/// Standart application text field
class AppTextField extends StatelessWidget {
  /// Creates instance of [AppTextField]
  const AppTextField({
    this.errorText,
    this.filled = false,
    this.obscureText = false,
    super.key,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.textEditingController,
    this.focusNode,
    this.fillColor,
    this.hint,
  });

  /// Initial value for text field
  final String? initialValue;

  /// Hint value
  final String? hint;

  /// On changed text inside the text field
  final void Function(String value)? onChanged;

  /// Whether this text field is enabled
  final bool enabled;

  /// Controller for the text field
  final TextEditingController? textEditingController;

  /// Focus node for the text field
  final FocusNode? focusNode;

  ///If true the decoration's container is filled with [fillColor].
  final bool filled;
  // The base fill color of the decoration's container color.

  /// Fill color, is active only when [filled] is true
  final Color? fillColor;

  /// Should obscure text
  final bool obscureText;

  final String? errorText;

  static final InputBorder _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: enabled,
      cursorColor: context.theme.primaryColor,
      decoration: InputDecoration(
        enabledBorder: _defaultInputBorder.copyWith(
          borderSide: BorderSide(
            color: context.theme.primaryColorLight,
          ),
        ),
        errorText: errorText,
        disabledBorder: _defaultInputBorder.copyWith(
          borderSide: BorderSide(
            color: context.theme.disabledColor,
          ),
        ),
        enabled: enabled,
        focusedBorder: _defaultInputBorder.copyWith(
          borderSide: BorderSide(
            color: context.theme.primaryColor,
          ),
        ),
        errorBorder: _defaultInputBorder.copyWith(
          borderSide: BorderSide(
            color: context.theme.primaryColorLight,
          ),
        ),
        focusedErrorBorder: _defaultInputBorder.copyWith(
          borderSide: BorderSide(
            color: context.theme.primaryColor,
          ),
        ),
        filled: filled,
        fillColor: fillColor,
        hintText: hint,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('initialValue', initialValue))
      ..add(
        ObjectFlagProperty<void Function(String value)?>.has(
          'onChanged',
          onChanged,
        ),
      )
      ..add(
        DiagnosticsProperty<TextEditingController?>(
          'textEditingController',
          textEditingController,
        ),
      )
      ..add(DiagnosticsProperty<bool?>('enabled', enabled))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(DiagnosticsProperty<bool>('filled', filled))
      ..add(ColorProperty('fillColor', fillColor))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty<bool>('obscureText', obscureText));
    properties.add(StringProperty('errorText', errorText));
  }
}
