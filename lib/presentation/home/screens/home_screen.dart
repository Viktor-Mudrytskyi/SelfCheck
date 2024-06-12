import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/presentation/auth/screens/auth_screen.dart';
import 'package:self_check/presentation/basic/remove_focus_scaffold.dart';
import 'package:self_check/presentation/home/bloc/user_cubit/user_cubit.dart';
import 'package:self_check/presentation/home/screens/all_words_screen.dart';
import 'package:self_check/presentation/home/widgets/custom_app_bar.dart';
import 'package:self_check/presentation/home/widgets/custom_drawer.dart';
import 'package:self_check/presentation/home/widgets/custom_floating_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RemoveFocusScaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      floatingActionButton: CustomFloatingButton(
        onTap: () {},
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          state.mapOrNull(
            unauthenticated: (_) {
              unawaited(
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => const AuthScreen(),
                  ),
                ),
              );
            },
          );
        },
        child: const AllWordsScreen(),
      ),
    );
  }
}
