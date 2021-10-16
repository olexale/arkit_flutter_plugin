import 'dart:math';

String randomString({int length = 16}) {
  final rand = Random();
  final codeUnits = List.generate(length, (index) {
    return rand.nextInt(33) + 89;
  });

  return String.fromCharCodes(codeUnits);
}
