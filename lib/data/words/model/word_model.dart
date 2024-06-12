class WordModel {
  const WordModel({
    required this.word,
    required this.description,
    required this.url,
    required this.uid,
  });

  factory WordModel.fromJson(Map<String, dynamic> map) {
    return WordModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      word: map['word'] != null ? map['word'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  final String? uid;
  final String? word;
  final String? description;
  final String? url;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'uid': uid,
      'word': word,
      'description': description,
      'url': url,
    };
  }
}
