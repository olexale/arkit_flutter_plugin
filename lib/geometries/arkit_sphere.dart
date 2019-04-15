import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:arkit_plugin/geometries/arkit_position.dart';
import 'package:meta/meta.dart';

class ARKitSphere extends ARKitGeometry {
  ARKitSphere({
    @required ARKitPosition position,
    @required this.radius,
    List<ARKitMaterial> materials,
  }) : super(position, materials: materials);

  final double radius;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'radius': radius,
        'position': position.toMap(),
        'materials': materials.map((m) => m.toMap()).toList(),
      };
}
