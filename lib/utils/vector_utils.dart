import 'package:vector_math/vector_math_64.dart';

Map<String, double> convertVector3ToMap(Vector3 vector) =>
    vector == null ? null : {'x': vector.x, 'y': vector.y, 'z': vector.z};
Map<String, double> convertVector4ToMap(Vector4 vector) => vector == null
    ? null
    : {'x': vector.x, 'y': vector.y, 'z': vector.z, 'w': vector.w};

Vector3 createVector3FromString(String str) {
  final coords = _getCoordsList(str);
  return Vector3.array(coords);
}

Vector4 createVector4FromString(String str) {
  final coords = _getCoordsList(str);
  return Vector4.array(coords);
}

List<double> _getCoordsList(String str) =>
    str.split(' ').map((s) => double.parse(s)).toList();
