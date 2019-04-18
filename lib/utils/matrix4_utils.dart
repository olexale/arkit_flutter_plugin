import 'package:flutter/widgets.dart';

Matrix4 getMatrixFromString(String str) {
  final numbers = str.trimRight().split(' ');
  final parsed = numbers.map((s) => double.parse(s)).toList();
  return Matrix4.fromList(parsed);
}
