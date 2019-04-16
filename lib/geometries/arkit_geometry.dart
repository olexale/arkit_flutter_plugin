import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:arkit_plugin/geometries/arkit_vector3.dart';

/// ARKitGeometry is an abstract class that represents the geometry that can be attached to a SCNNode.
abstract class ARKitGeometry {
  ARKitGeometry(
    this.position, {
    this.materials,
    this.scale,
    this.name,
  });

  /// Specifies the receiver's materials array.
  /// Each geometry element can be rendered using a different material.
  /// The index of the material used for a geometry element is equal to the index of that element modulo the number of materials.
  final List<ARKitMaterial> materials;

  /// Determines the receiver's position.
  final ARKitVector3 position;

  /// Determines the receiver's scale.
  final ARKitVector3 scale;

  /// Determines the name of the receiver.
  final String name;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'position': position.toMap(),
        'scale': scale?.toMap(),
        'name': name,
        'materials':
            materials != null ? materials.map((m) => m.toMap()).toList() : null,
      }..removeWhere((String k, dynamic v) => v == null);
}
