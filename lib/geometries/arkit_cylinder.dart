import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_cylinder.g.dart';

/// ARKitCylinder represents a cylinder with controllable height and radius.
@JsonSerializable()
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
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> height;

  /// The radius of the cylinder.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.5.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> radius;

  static ARKitCylinder fromJson(Map<String, dynamic> json) =>
      _$ARKitCylinderFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitCylinderToJson(this)..addAll({'dartType': 'ARKitCylinder'});
}
