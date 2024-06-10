import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/presentation/auth/screens/auth_screen.dart';
import 'package:self_check/presentation/basic/buttons/primary_button.dart';
import 'package:self_check/presentation/basic/remove_focus_scaffold.dart';
import 'package:self_check/presentation/home/bloc/user_cubit/user_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RemoveFocusScaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          state.mapOrNull(
            unauthenticated: (_) {
              unawaited(
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => const AuthScreen(),
                  ),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          final userCubit = context.read<UserCubit>();
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.maybeMap(
                  orElse: Offstage.new,
                  authenticated: (authenticated) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        authenticated.user.email ?? '',
                      ),
                      PrimaryButton(
                        title: 'Sign out',
                        onPressed: userCubit.signOut,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
