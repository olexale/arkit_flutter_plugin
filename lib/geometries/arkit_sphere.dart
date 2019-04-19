import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';

/// Represents a sphere with controllable radius
class ARKitSphere extends ARKitGeometry {
  ARKitSphere({
    this.radius = 0.5,
    List<ARKitMaterial> materials,
  }) : super(
          materials: materials,
        );

  /// The sphere radius.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  final double radius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'radius': radius,
      }..addAll(super.toMap());
}
