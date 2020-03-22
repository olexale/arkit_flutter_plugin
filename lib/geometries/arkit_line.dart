import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math_64.dart';

part 'arkit_line.g.dart';

/// Represents a line between 2 vectors
@JsonSerializable()
class ARKitLine extends ARKitGeometry {
  ARKitLine({
    @required this.fromVector,
    @required this.toVector,
    List<ARKitMaterial> materials,
  }) : super(
          materials: materials,
        );

  /// Line initial vector position
  @Vector3Converter()
  final Vector3 fromVector;

  /// Line final vector positon
  @Vector3Converter()
  final Vector3 toVector;

  static ARKitLine fromJson(Map<String, dynamic> json) =>
      _$ARKitLineFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitLineToJson(this)..addAll({'dartType': 'ARKitLine'});
}
