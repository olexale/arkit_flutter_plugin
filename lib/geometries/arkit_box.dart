import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';

/// ARKitBox represents a box with rectangular sides and optional chamfers.
class ARKitBox extends ARKitGeometry {
  ARKitBox({
    this.width = 1,
    this.height = 1,
    this.length = 1,
    this.chamferRadius = 0,
    List<ARKitMaterial> materials,
  }) : super(
          materials: materials,
        );

  /// The width of the box.
  /// If the value is less than or equal to 0, the geometry is empty. The default value is 1.
  final double width;

  /// The height of the box.
  /// If the value is less than or equal to 0, the geometry is empty. The default value is 1.
  final double height;

  /// The length of the box.
  /// If the value is less than or equal to 0, the geometry is empty. The default value is 1.
  final double length;

  /// The chamfer radius.
  /// If the value is strictly less than 0, the geometry is empty. The default value is 0.
  final double chamferRadius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'width': width,
        'height': height,
        'length': length,
        'chamferRadius': chamferRadius,
      }..addAll(super.toMap());
}
