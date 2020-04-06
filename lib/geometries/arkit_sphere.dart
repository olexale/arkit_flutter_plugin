import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_sphere.g.dart';

/// Represents a sphere with controllable radius
@JsonSerializable()
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
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> radius;

  static ARKitSphere fromJson(Map<String, dynamic> json) =>
      _$ARKitSphereFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitSphereToJson(this)..addAll({'dartType': 'ARKitSphere'});
}
