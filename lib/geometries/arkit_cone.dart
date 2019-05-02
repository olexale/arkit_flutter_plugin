import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:flutter/widgets.dart';

/// ARKitCone represents a cone with controllable height, top radius and bottom radius.
class ARKitCone extends ARKitGeometry {
  ARKitCone({
    double height = 1,
    double topRadius = 0,
    double bottomRadius = 0.5,
    List<ARKitMaterial> materials,
  })  : height = ValueNotifier(height),
        topRadius = ValueNotifier(topRadius),
        bottomRadius = ValueNotifier(bottomRadius),
        super(
          materials: materials,
        );

  /// The height of the cylinder.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final ValueNotifier<double> height;

  /// The radius at the top of the cone.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.
  final ValueNotifier<double> topRadius;

  /// The radius at the bottom of the cone.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  final ValueNotifier<double> bottomRadius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'height': height.value,
        'topRadius': topRadius.value,
        'bottomRadius': bottomRadius.value,
      }..addAll(super.toMap());
}
