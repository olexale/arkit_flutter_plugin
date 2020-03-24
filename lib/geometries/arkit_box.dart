import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_box.g.dart';

/// ARKitBox represents a box with rectangular sides and optional chamfers.
@JsonSerializable()
class ARKitBox extends ARKitGeometry {
  ARKitBox({
    double width = 1,
    double height = 1,
    double length = 1,
    this.chamferRadius = 0,
    List<ARKitMaterial> materials,
  })  : width = ValueNotifier(width),
        height = ValueNotifier(height),
        length = ValueNotifier(length),
        super(
          materials: materials,
        );

  /// The width of the box.
  /// If the value is less than or equal to 0, the geometry is empty. The default value is 1.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> width;

  /// The height of the box.
  /// If the value is less than or equal to 0, the geometry is empty. The default value is 1.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> height;

  /// The length of the box.
  /// If the value is less than or equal to 0, the geometry is empty. The default value is 1.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> length;

  /// The chamfer radius.
  /// If the value is strictly less than 0, the geometry is empty. The default value is 0.
  final double chamferRadius;

  static ARKitBox fromJson(Map<String, dynamic> json) =>
      _$ARKitBoxFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitBoxToJson(this)..addAll({'dartType': 'ARKitBox'});
}
