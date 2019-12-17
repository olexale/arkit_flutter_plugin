import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:flutter/widgets.dart';

/// ARKitCapsule represents a capsule with controllable height and cap radius.
class ARKitCapsule extends ARKitGeometry {
  ARKitCapsule({
    double capRadius = 0.5,
    double height = 2,
    List<ARKitMaterial> materials,
  })  : capRadius = ValueNotifier(capRadius),
        height = ValueNotifier(height),
        super(
          materials: materials,
        );

  /// The cap radius of the capsule.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  final ValueNotifier<double> capRadius;

  /// The height of the capsule.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 2.
  final ValueNotifier<double> height;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'capRadius': capRadius.value,
        'height': height.value,
      }..addAll(super.toMap());
}
