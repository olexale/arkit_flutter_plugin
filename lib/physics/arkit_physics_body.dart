import 'package:arkit_plugin/physics/arkit_physics_body_type.dart';
import 'package:arkit_plugin/physics/arkit_physics_shape.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_physics_body.g.dart';

/// The ARKitPhysicsBody class describes the physics properties (such as mass, friction...) of a node.
@JsonSerializable()
class ARKitPhysicsBody {
  const ARKitPhysicsBody(
    this.type, {
    this.shape,
    this.categoryBitMask,
  });

  /// Specifies the type of the receiver.
  @ARKitPhysicsBodyTypeConverter()
  final ARKitPhysicsBodyType type;

  /// Specifies the shape of the receiver.
  @ARKitPhysicsShapeConverter()
  final ARKitPhysicsShape shape;

  /// Defines what logical 'categories' this body belongs to.
  /// Defaults to SCNPhysicsCollisionCategoryStatic for static bodies and SCNPhysicsCollisionCategoryDefault for the other body types.
  final int categoryBitMask;

  static ARKitPhysicsBody fromJson(Map<String, dynamic> json) =>
      _$ARKitPhysicsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitPhysicsBodyToJson(this);
}
