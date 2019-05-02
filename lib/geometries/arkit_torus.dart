import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:flutter/widgets.dart';

/// ARKitTorus represents a torus with controllable ring radius and pipe radius.
class ARKitTorus extends ARKitGeometry {
  ARKitTorus({
    double ringRadius = 0.5,
    double pipeRadius = 0.25,
    List<ARKitMaterial> materials,
  })  : ringRadius = ValueNotifier(ringRadius),
        pipeRadius = ValueNotifier(pipeRadius),
        super(
          materials: materials,
        );

  /// The radius of the torus ring.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  final ValueNotifier<double> ringRadius;

  /// The radius of the torus pipe.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.25.
  final ValueNotifier<double> pipeRadius;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'ringRadius': ringRadius.value,
        'pipeRadius': pipeRadius.value,
      }..addAll(super.toMap());
}
