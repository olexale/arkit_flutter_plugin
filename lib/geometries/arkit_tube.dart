import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:flutter/widgets.dart';

/// ARKitTube represents a tube with controllable height, inner radius and outer radius.
class ARKitTube extends ARKitGeometry {
  ARKitTube({
    double innerRadius = 0.25,
    double outerRadius = 0.5,
    double height = 1,
    List<ARKitMaterial> materials,
  })  : height = ValueNotifier(height),
        innerRadius = ValueNotifier(innerRadius),
        outerRadius = ValueNotifier(outerRadius),
        super(
          materials: materials,
        );

  /// The height of the tube.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final ValueNotifier<double> height;

  /// The inner radius of the tube.
  /// If the value is less than or equal to 0, or if it is greater than or equal to the outer radius, then the geometry is empty.
  /// The default value is 0.25.
  final ValueNotifier<double> innerRadius;

  /// The outer radius of the tube.
  /// If the value is less than or equal to 0, or if it is less than or equal to the inner radius, then the geometry is empty.
  /// The default value is 0.5.
  final ValueNotifier<double> outerRadius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'height': height.value,
        'innerRadius': innerRadius.value,
        'outerRadius': outerRadius.value,
      }..addAll(super.toMap());
}
