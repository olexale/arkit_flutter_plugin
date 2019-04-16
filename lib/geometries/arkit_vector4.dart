import 'package:meta/meta.dart';

@immutable
class ARKitVector4 {
  const ARKitVector4(this.x, this.y, this.z, this.w);

  final double x;
  final double y;
  final double z;
  final double w;

  Map<String, double> toMap() => {'x': x, 'y': y, 'z': z, 'w': w};
}
