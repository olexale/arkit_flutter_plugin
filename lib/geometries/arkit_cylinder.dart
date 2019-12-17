import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:flutter/widgets.dart';

/// ARKitCylinder represents a cylinder with controllable height and radius.
class ARKitCylinder extends ARKitGeometry {
  ARKitCylinder({
    double height = 1,
    double radius = 0.5,
    List<ARKitMaterial> materials,
  })  : height = ValueNotifier(height),
        radius = ValueNotifier(radius),
        super(
          materials: materials,
        );

  /// The height of the cylinder.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final ValueNotifier<double> height;

  /// The radius of the cylinder.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  final ValueNotifier<double> radius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'height': height.value,
        'radius': radius.value,
      }..addAll(super.toMap());
}
