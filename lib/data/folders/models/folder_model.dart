class FolderModel {
  const FolderModel({required this.name});

  factory FolderModel.fromJson(Map<String, dynamic> map) {
    return FolderModel(
      name: map['name'] as String?,
    );
  }

  final String? name;
  // final List<WordReference>? wordRefs;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
    };
  }
}

class WordReference {
  const WordReference({
    required this.word,
    required this.wordRef,
  });

  factory WordReference.fromJson(Map<String, dynamic> map) {
    return WordReference(
      word: map['word'] as String?,
      wordRef: map['wordRef'] as String?,
    );
  }

  final String? word;
  final String? wordRef;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'word': word,
      'wordRef': wordRef,
    };
  }
}
