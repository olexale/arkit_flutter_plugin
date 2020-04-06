import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_cone.g.dart';

/// ARKitCone represents a cone with controllable height, top radius and bottom radius.
@JsonSerializable()
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
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> height;

  /// The radius at the top of the cone.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> topRadius;

  /// The radius at the bottom of the cone.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> bottomRadius;

  static ARKitCone fromJson(Map<String, dynamic> json) =>
      _$ARKitConeFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitConeToJson(this)..addAll({'dartType': 'ARKitCone'});
}
