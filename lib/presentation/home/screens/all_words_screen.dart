import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/core/di.dart';
import 'package:self_check/presentation/basic/loaders/app_loader.dart';
import 'package:self_check/presentation/home/bloc/all_words_cubit/all_words_cubit.dart';
import 'package:self_check/presentation/home/bloc/user_cubit/user_cubit.dart';
import 'package:self_check/presentation/home/widgets/word_widget.dart';

class AllWordsScreen extends StatelessWidget {
  const AllWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: Offstage.new,
          authenticated: (authenticated) => BlocProvider<AllWordsCubit>(
            create: (context) => getIt()..init(authenticated.user.uid),
            child: BlocBuilder<AllWordsCubit, AllWordsState>(
              builder: (context, state) {
                return _AlWordsWidget(
                  state: state,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _AlWordsWidget extends StatelessWidget {
  const _AlWordsWidget({required this.state});
  final AllWordsState state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        state.map(
          loading: (_) => const SliverFillRemaining(
            child: AppLoader(),
          ),
          loaded: (loaded) => SliverList.separated(
            itemCount: loaded.wordList.length,
            itemBuilder: (context, index) => WordWidget(
              dto: loaded.wordList[index],
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 1,
            ),
          ),
          error: (error) => SliverFillRemaining(
            child: Center(
              child: Text(error.failure.message),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AllWordsState>('state', state));
  }
}
