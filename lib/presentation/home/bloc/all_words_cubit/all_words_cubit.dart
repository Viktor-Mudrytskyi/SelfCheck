import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_check/core/failures/failure.dart';
import 'package:self_check/core/managers/firestore_manager.dart';
import 'package:self_check/presentation/home/dto/word_dto.dart';
import 'package:self_check/presentation/home/parsers/word_parser.dart';

part 'all_words_state.dart';

class AllWordsCubit extends Cubit<AllWordsState> {
  AllWordsCubit({required FirestoreManager firestoreManager})
      : _firestoreManager = firestoreManager,
        super(LoadingAllWordsState());

  final FirestoreManager _firestoreManager;

  late String _userUid;

  static final WordParser _wordParser = WordParser();

  Future<void> init(String userUid) async {
    _userUid = userUid;
    emit(LoadingAllWordsState());
    final res = await _firestoreManager.getWords(uid: _userUid);
    res.fold(
      success: (data) => emit(
        LoadedAllWordsState(
          wordList: _wordParser.parseList(data),
        ),
      ),
      failure: (failure) => emit(
        ErrorAllWordsState(
          failure: failure,
        ),
      ),
    );
  }
}
