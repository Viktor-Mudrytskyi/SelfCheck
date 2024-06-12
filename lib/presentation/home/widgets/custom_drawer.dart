import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/presentation/basic/buttons/primary_button.dart';
import 'package:self_check/presentation/home/bloc/user_cubit/user_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Drawer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 30,
              ),
              child: state.maybeMap(
                orElse: Offstage.new,
                authenticated: (authenticated) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      authenticated.user.email ?? '',
                    ),
                    PrimaryButton(
                      title: 'Sign out',
                      onPressed: () async {
                        await context.read<UserCubit>().signOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
