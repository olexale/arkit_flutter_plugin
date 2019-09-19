import 'package:arkit_plugin/utils/vector_utils.dart';
import 'package:vector_math/vector_math_64.dart';

Matrix4 getMatrixFromString(String str) {
  final numbers = str.trimRight().split(' ');
  final parsed = numbers.map((s) => double.parse(s)).toList();
  return Matrix4.fromList(parsed);
}

Map<String, Map<String, double>> convertMatrixToMap(Matrix4 matrix) {
  final a = matrix.getColumn(0);
  final b = matrix.getColumn(1);
  final c = matrix.getColumn(2);
  final d = matrix.getColumn(3);
  return {
    'a': convertVector4ToMap(a),
    'b': convertVector4ToMap(b),
    'c': convertVector4ToMap(c),
    'd': convertVector4ToMap(d),
  };
}
