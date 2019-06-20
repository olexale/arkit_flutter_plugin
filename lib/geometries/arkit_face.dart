import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';

/// An object representing the geometry of a face.
/// The face geometry will have a constant number of triangles
/// and vertices, updating only the vertex positions from frame to frame.
class ARKitFace extends ARKitGeometry {
  ARKitFace({
    List<ARKitMaterial> materials,
  }) : super(
          materials: materials,
        );
}
