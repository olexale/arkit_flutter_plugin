import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_tube.g.dart';

/// ARKitTube represents a tube with controllable height, inner radius and outer radius.
@JsonSerializable()
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
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> height;

  /// The inner radius of the tube.
  /// If the value is less than or equal to 0, or if it is greater than or equal to the outer radius, then the geometry is empty.
  /// The default value is 0.25.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> innerRadius;

  /// The outer radius of the tube.
  /// If the value is less than or equal to 0, or if it is less than or equal to the inner radius, then the geometry is empty.
  /// The default value is 0.5.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> outerRadius;

  static ARKitTube fromJson(Map<String, dynamic> json) =>
      _$ARKitTubeFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitTubeToJson(this)..addAll({'dartType': 'ARKitTube'});
}
