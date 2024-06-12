part of 'all_words_cubit.dart';

@immutable
sealed class AllWordsState {
  const AllWordsState();

  /// Exhaustive matching
  T map<T>({
    required T Function(
      LoadingAllWordsState loading,
    ) loading,
    required T Function(
      LoadedAllWordsState loaded,
    ) loaded,
    required T Function(
      ErrorAllWordsState error,
    ) error,
  }) {
    return switch (this) {
      LoadingAllWordsState() => loading(
          this as LoadingAllWordsState,
        ),
      LoadedAllWordsState() => loaded(
          this as LoadedAllWordsState,
        ),
      ErrorAllWordsState() => error(
          this as ErrorAllWordsState,
        ),
    };
  }

  /// Match or else
  T maybeMap<T>({
    required T Function() orElse,
    T Function(
      LoadingAllWordsState loading,
    )? loading,
    T Function(
      LoadedAllWordsState loaded,
    )? loaded,
    T Function(
      ErrorAllWordsState error,
    )? error,
  }) {
    return switch (this) {
      LoadingAllWordsState() => loading != null
          ? loading(
              this as LoadingAllWordsState,
            )
          : orElse(),
      LoadedAllWordsState() => loaded != null
          ? loaded(
              this as LoadedAllWordsState,
            )
          : orElse(),
      ErrorAllWordsState() => error != null
          ? error(
              this as ErrorAllWordsState,
            )
          : orElse(),
    };
  }

  /// Match or null
  T? mapOrNull<T>({
    T Function(
      LoadingAllWordsState loading,
    )? loading,
    T Function(
      LoadedAllWordsState loaded,
    )? loaded,
    T Function(
      ErrorAllWordsState error,
    )? error,
  }) {
    return switch (this) {
      LoadingAllWordsState() => loading != null
          ? loading(
              this as LoadingAllWordsState,
            )
          : null,
      LoadedAllWordsState() => loaded != null
          ? loaded(
              this as LoadedAllWordsState,
            )
          : null,
      ErrorAllWordsState() => error != null
          ? error(
              this as ErrorAllWordsState,
            )
          : null,
    };
  }
}

final class LoadingAllWordsState extends AllWordsState {}

final class LoadedAllWordsState extends AllWordsState {
  const LoadedAllWordsState({required this.wordList});

  final List<WordDto> wordList;
}

final class ErrorAllWordsState extends AllWordsState {
  const ErrorAllWordsState({required this.failure});

  final Failure failure;
}
