import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_physics_shape.g.dart';

/// ARKitPhysicsShape represents the shape of a physics body.
@JsonSerializable()
class ARKitPhysicsShape {
  const ARKitPhysicsShape(this.geometry);

  @ARKitGeometryConverter()
  final ARKitGeometry geometry;

  static ARKitPhysicsShape fromJson(Map<String, dynamic> json) =>
      _$ARKitPhysicsShapeFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitPhysicsShapeToJson(this);
}
