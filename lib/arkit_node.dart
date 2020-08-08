import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/light/arkit_light.dart';
import 'package:arkit_plugin/physics/arkit_physics_body.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:arkit_plugin/utils/random_string.dart' as random_string;
import 'package:vector_math/vector_math_64.dart';

/// ARKitNode is the model class for node-tree objects.
/// It encapsulates the position, rotations, and other transforms of a node, which define a coordinate system.
/// The coordinate systems of all the sub-nodes are relative to the one of their parent node.
class ARKitNode {
  ARKitNode({
    this.geometry,
    this.physicsBody,
    this.light,
    this.renderingOrder = 0,
    bool isHidden = false,
    Vector3 position,
    Vector3 scale,
    Vector4 rotation,
    Vector3 eulerAngles,
    String name,
  })  : name = name ?? random_string.randomString(),
        position = ValueNotifier(position),
        scale = ValueNotifier(scale ?? Vector3.all(1)),
        rotation = ValueNotifier(rotation ?? Vector4.zero()),
        eulerAngles = ValueNotifier(eulerAngles ?? Vector3.zero()),
        isHidden = ValueNotifier(isHidden);

  /// Returns the geometry attached to the receiver.
  final ARKitGeometry geometry;

  /// Determines the receiver's position.
  final ValueNotifier<Vector3> position;

  /// Determines the receiver's scale.
  final ValueNotifier<Vector3> scale;

  /// Determines the receiver's rotation.
  /// The rotation is axis angle rotation.
  /// The three first components are the axis, the fourth one is the rotation (in radian).
  final ValueNotifier<Vector4> rotation;

  /// Determines the receiver's euler angles.
  /// The order of components in this vector matches the axes of rotation:
  /// 1. Pitch (the x component) is the rotation about the node's x-axis (in radians)
  /// 2. Yaw   (the y component) is the rotation about the node's y-axis (in radians)
  /// 3. Roll  (the z component) is the rotation about the node's z-axis (in radians)
  ///
  /// SceneKit applies these rotations in the reverse order of the components:
  /// 1. first roll
  /// 2. then yaw
  /// 3. then pitch
  final ValueNotifier<Vector3> eulerAngles;

  /// Determines the name of the receiver.
  /// Will be autogenerated if not defined.
  final String name;

  /// The description of the physics body of the receiver.
  final ARKitPhysicsBody physicsBody;

  /// Determines the light attached to the receiver.
  final ARKitLight light;

  /// Determines the rendering order of the receiver.
  /// Nodes with greater rendering orders are rendered last.
  /// Defaults to 0.
  final int renderingOrder;

  /// Determines the visibility of the node’s contents. Animatable.
  /// Defaults to false.
  final ValueNotifier<bool> isHidden;

  static const _boolValueNotifierConverter = ValueNotifierConverter<bool>();
  static const _vector3ValueNotifierConverter = Vector3ValueNotifierConverter();
  static const _vector4ValueNotifierConverter = Vector4ValueNotifierConverter();

  Map<String, dynamic> toMap() => <String, dynamic>{
        'dartType': runtimeType.toString(),
        'geometry': geometry?.toJson(),
        'position': _vector3ValueNotifierConverter.toJson(position),
        'scale': _vector3ValueNotifierConverter.toJson(scale),
        'rotation': _vector4ValueNotifierConverter.toJson(rotation),
        'eulerAngles': _vector3ValueNotifierConverter.toJson(eulerAngles),
        'physicsBody': physicsBody?.toJson(),
        'light': light?.toJson(),
        'name': name,
        'renderingOrder': renderingOrder,
        'isHidden': _boolValueNotifierConverter(isHidden),
      }..removeWhere((String k, dynamic v) => v == null);
}
