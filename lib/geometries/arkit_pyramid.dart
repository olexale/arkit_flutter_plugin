import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:flutter/widgets.dart';

/// ARKitPyramid represents a right pyramid with a rectangular base.
class ARKitPyramid extends ARKitGeometry {
  ARKitPyramid({
    double height = 1,
    double width = 1,
    double length = 1,
    List<ARKitMaterial> materials,
  })  : height = ValueNotifier(height),
        width = ValueNotifier(width),
        length = ValueNotifier(length),
        super(
          materials: materials,
        );

  /// The height of the pyramid.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final ValueNotifier<double> height;

  /// The width of the pyramid base.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final ValueNotifier<double> width;

  /// The length of the pyramid base.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final ValueNotifier<double> length;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'height': height.value,
        'width': width.value,
        'length': length.value,
      }..addAll(super.toMap());
}
