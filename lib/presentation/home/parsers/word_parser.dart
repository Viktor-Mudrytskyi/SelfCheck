import 'package:self_check/core/parser.dart';
import 'package:self_check/data/words/model/word_model.dart';
import 'package:self_check/presentation/home/dto/word_dto.dart';

class WordParser implements Parser<WordDto, WordModel> {
  @override
  WordDto parse(WordModel param) {
    return WordDto(
      word: param.word ?? '',
      url: param.url ?? '',
      description: param.description ?? '',
      uid: param.uid ?? '',
    );
  }

  List<WordDto> parseList(List<WordModel> wordModels) {
    return wordModels.map(parse).toList();
  }
}
