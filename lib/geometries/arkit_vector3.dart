import 'package:meta/meta.dart';

@immutable
class ARKitVector3 {
  const ARKitVector3(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;

  Map<String, double> toMap() => {'x': x, 'y': y, 'z': z};

  static ARKitVector3 fromString(String str) {
    final coords = str.split(' ').map((s) => double.parse(s)).toList();
    return ARKitVector3(coords[0], coords[1], coords[2]);
  }
}
