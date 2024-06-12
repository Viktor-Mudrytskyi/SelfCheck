import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_check/presentation/home/dto/word_dto.dart';

class WordWidget extends StatelessWidget {
  const WordWidget({
    required this.dto,
    super.key,
  });
  final WordDto dto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dto.word),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WordDto>('dto', dto));
  }
}
