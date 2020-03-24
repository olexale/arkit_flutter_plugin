import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_torus.g.dart';

/// ARKitTorus represents a torus with controllable ring radius and pipe radius.
@JsonSerializable()
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
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> ringRadius;

  /// The radius of the torus pipe.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 0.25.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> pipeRadius;

  static ARKitTorus fromJson(Map<String, dynamic> json) =>
      _$ARKitTorusFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitTorusToJson(this)..addAll({'dartType': 'ARKitTorus'});
}
