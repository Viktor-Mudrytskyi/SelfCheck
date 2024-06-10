import 'package:flutter/material.dart';
import 'package:self_check/presentation/basic/loaders/app_loader.dart';

class FillLoader extends StatelessWidget {
  const FillLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        child: AppLoader(),
      ),
    );
  }
}
