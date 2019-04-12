import 'package:arkit_plugin/arkit_position.dart';
import 'package:meta/meta.dart';

class ARKitSphere {
  ARKitSphere({@required this.position, @required this.radius});

  final ARKitPosition position;
  final double radius;

  Map<String, dynamic> toMap() {
    return {'radius': radius, 'position': position.toMap()};
  }
}
