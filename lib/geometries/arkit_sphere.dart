import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:arkit_plugin/geometries/arkit_vector3.dart';
import 'package:meta/meta.dart';

/// Represents a sphere with controllable radius
class ARKitSphere extends ARKitGeometry {
  ARKitSphere({
    @required ARKitVector3 position,
    this.radius = 0.5,
    ARKitVector3 scale,
    List<ARKitMaterial> materials,
    String name,
  }) : super(
          position,
          materials: materials,
          scale: scale,
          name: name,
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
