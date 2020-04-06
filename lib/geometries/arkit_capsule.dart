import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_capsule.g.dart';

/// ARKitCapsule represents a capsule with controllable height and cap radius.
@JsonSerializable()
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
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> capRadius;

  /// The height of the capsule.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 2.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> height;

  static ARKitCapsule fromJson(Map<String, dynamic> json) =>
      _$ARKitCapsuleFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitCapsuleToJson(this)..addAll({'dartType': 'ARKitCapsule'});
}
