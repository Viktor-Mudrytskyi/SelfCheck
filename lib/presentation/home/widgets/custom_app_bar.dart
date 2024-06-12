import 'package:flutter/material.dart';
import 'package:self_check/core/extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key});

  static const double _defaultHeight = 60;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.primaryColor,
      child: Padding(
        padding: context.systemPadding,
        child: SizedBox(
          height: _defaultHeight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (Scaffold.of(context).isDrawerOpen) {
                      Scaffold.of(context).closeDrawer();
                    } else {
                      Scaffold.of(context).openDrawer();
                    }
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_defaultHeight);

  @override
  Widget get child => const Placeholder();
}
