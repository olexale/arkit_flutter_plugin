import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math_64.dart';

/// Represents a sphere with controllable radius
class ARKitSphere extends ARKitGeometry {
  ARKitSphere({
    @required Vector3 position,
    this.radius = 0.5,
    Vector3 scale,
    Vector4 rotation,
    List<ARKitMaterial> materials,
    String name,
  }) : super(
          position,
          materials: materials,
          scale: scale,
          rotation: rotation,
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
