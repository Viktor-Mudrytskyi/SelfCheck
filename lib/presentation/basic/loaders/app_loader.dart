import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.radius});
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _PlatformSpinner(
        radius: radius,
      ),
    );
  }
}

class _PlatformSpinner extends StatelessWidget {
  const _PlatformSpinner({this.radius});
  final double? radius;

  static const double _defaultRadius = 10;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        color: context.theme.primaryColor,
        radius: radius ?? _defaultRadius,
      );
    } else {
      final size = (radius ?? _defaultRadius) * 2;
      return SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      );
    }
  }
}
