import 'package:arkit_plugin/geometries/arkit_geometry.dart';

/// ARKitPhysicsShape represents the shape of a physics body.
class ARKitPhysicsShape {
  /// Creates an instance of a physics shape based on a geometry.
  ARKitPhysicsShape.fromGeometry(ARKitGeometry geometry) : _geometry = geometry;

  final ARKitGeometry _geometry;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'geometry': _geometry?.toMap(),
      }..removeWhere((String k, dynamic v) => v == null);
}
