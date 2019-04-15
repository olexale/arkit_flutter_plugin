import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:arkit_plugin/geometries/arkit_position.dart';

/// ARKitGeometry is an abstract class that represents the geometry that can be attached to a SCNNode.
abstract class ARKitGeometry {
  ARKitGeometry(
    this.position, {
    this.materials,
  });

  final List<ARKitMaterial> materials;
  final ARKitPosition position;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'position': position.toMap(),
        'materials':
            materials != null ? materials.map((m) => m.toMap()).toList() : null,
      }..removeWhere((String k, dynamic v) => v == null);
}
