import 'dart:math';

final class TestUtils {
  static const String _enChars = 'qwertyuiopasdfghjklzxcvbnm';
  static final Random _random = Random();
  String generateRandomString(int length) => String.fromCharCodes(
        Iterable<int>.generate(
          length,
          (_) => _enChars.codeUnitAt(
            _random.nextInt(_enChars.length),
          ),
        ),
      );
}
