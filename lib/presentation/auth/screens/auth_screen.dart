import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/core/di.dart';
import 'package:self_check/core/extensions.dart';
import 'package:self_check/presentation/auth/bloc/auth_cubit/auth_cubit.dart';
import 'package:self_check/presentation/basic/buttons/primary_button.dart';
import 'package:self_check/presentation/basic/buttons/secondary_button.dart';
import 'package:self_check/presentation/basic/loaders/full_screen_loader.dart';
import 'package:self_check/presentation/basic/loaders/stacked_loader.dart';
import 'package:self_check/presentation/basic/remove_focus_scaffold.dart';
import 'package:self_check/presentation/basic/text_fields/app_text_field.dart';
import 'package:self_check/presentation/home/screens/home_screen.dart';

/// Main screen for auth
class AuthScreen extends StatelessWidget {
  /// Creates instance of [AuthScreen]
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.mapOrNull(
            success: (success) {
              unawaited(
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => const HomeScreen(),
                  ),
                ),
              );
            },
          );
        },
        listenWhen: (previous, current) => current.maybeMap(
          orElse: () => false,
          success: (_) => true,
        ),
        buildWhen: (previous, current) => current.maybeMap(
          orElse: () => true,
          error: (error) => false,
        ),
        builder: (context, state) {
          return StackedLoader(
            isLoading: state.maybeMap(
              orElse: () => false,
              loaded: (loaded) => loaded.showScreenLoader,
            ),
            child: RemoveFocusScaffold(
              body: state.maybeMap(
                orElse: FillLoader.new,
                loaded: (loaded) => _Loaded(state: loaded),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.state});
  final LoadedAuthState state;
  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.mapOrNull(
          error: (error) {
            context.showSnackBar(error.failure.message);
          },
        );
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.systemPadding.top,
            right: 16,
            left: 16,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              const Text(
                'Hello',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 50),
              AppTextField(
                hint: 'Email',
                errorText: state.shouldShowError
                    ? state.emailValidator.failure?.message
                    : null,
                onChanged: authCubit.onChangeEmail,
              ),
              const SizedBox(height: 20),
              AppTextField(
                hint: 'Password',
                errorText: state.shouldShowError
                    ? state.passwordValidator.failure?.message
                    : null,
                obscureText: true,
                onChanged: authCubit.onChangePassword,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                title: 'Register',
                onPressed: authCubit.onRegister,
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                title: 'Log In',
                onPressed: authCubit.onSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<LoadedAuthState>('state', state));
  }
}
