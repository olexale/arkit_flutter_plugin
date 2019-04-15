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
}
