import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:arkit_plugin/utils/vector_utils.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math_64.dart';

/// Represents a sphere with controllable radius
class ARKitLine extends ARKitGeometry {
  ARKitLine({
    @required this.fromVector,
    @required this.toVector,
    List<ARKitMaterial> materials,
  }) : super(
          materials: materials,
        );

  final Vector3 fromVector;
  final Vector3 toVector;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'fromVector': convertVector3ToMap(fromVector),
        'toVector': convertVector3ToMap(toVector),
      }..addAll(super.toMap());
}
