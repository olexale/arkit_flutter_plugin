import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:flutter/widgets.dart';

/// Represents a sphere with controllable radius
class ARKitSphere extends ARKitGeometry {
  ARKitSphere({
    double radius = 0.5,
    List<ARKitMaterial> materials,
  })  : radius = ValueNotifier(radius),
        super(
          materials: materials,
        );

  /// The sphere radius.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  final ValueNotifier<double> radius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'radius': radius.value,
      }..addAll(super.toMap());
}
