import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_plane.g.dart';

/// Represents a rectangle with controllable width and height. The plane has one visible side.
@JsonSerializable()
class ARKitPlane extends ARKitGeometry {
  ARKitPlane({
    double width = 1,
    double height = 1,
    this.widthSegmentCount = 1,
    this.heightSegmentCount = 1,
    List<ARKitMaterial> materials,
  })  : width = ValueNotifier(width),
        height = ValueNotifier(height),
        super(
          materials: materials,
        );

  /// The plane extent along the X axis.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> width;

  /// The plane extent along the Y axis.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> height;

  /// The number of subdivisions along the X axis.
  /// If the value is less than 1, the behavior is undefined.
  /// The default value is 1.
  final int widthSegmentCount;

  /// The number of subdivisions along the Y axis. The default value is 1.
  /// If the value is less than 1, the behavior is undefined.
  /// The default value is 1.
  final int heightSegmentCount;

  static ARKitPlane fromJson(Map<String, dynamic> json) =>
      _$ARKitPlaneFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitPlaneToJson(this)..addAll({'dartType': 'ARKitPlane'});
}
