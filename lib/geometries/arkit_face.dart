import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_face.g.dart';

/// An object representing the geometry of a face.
/// The face geometry will have a constant number of triangles
/// and vertices, updating only the vertex positions from frame to frame.
@JsonSerializable()
class ARKitFace extends ARKitGeometry {
  ARKitFace({
    List<ARKitMaterial> materials,
  }) : super(
          materials: materials,
        );

  static ARKitFace fromJson(Map<String, dynamic> json) =>
      _$ARKitFaceFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitFaceToJson(this)..addAll({'dartType': 'ARKitFace'});
}
