import 'package:arkit_plugin/physics/arkit_physics_body_type.dart';
import 'package:arkit_plugin/physics/arkit_physics_shape.dart';

/// The ARKitPhysicsBody class describes the physics properties (such as mass, friction...) of a node.
class ARKitPhysicsBody {
  ARKitPhysicsBody(
    this.type, {
    this.shape,
    this.categoryBitMask,
  });

  /// Specifies the type of the receiver.
  final ARKitPhysicsBodyType type;

  /// Specifies the shape of the receiver.
  final ARKitPhysicsShape shape;

  /// Defines what logical 'categories' this body belongs to.
  /// Defaults to SCNPhysicsCollisionCategoryStatic for static bodies and SCNPhysicsCollisionCategoryDefault for the other body types.
  final int categoryBitMask;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'type': type.index,
        'shape': shape?.toMap(),
        'categoryBitMask': categoryBitMask,
      }..removeWhere((String k, dynamic v) => v == null);
}
