import 'package:arkit_plugin/arkit_node.dart';
import 'package:arkit_plugin/light/arkit_light.dart';
import 'package:arkit_plugin/physics/arkit_physics_body.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

///  Node that references an external serialized node graph.
class ARKitReferenceNode extends ARKitNode {
  ARKitReferenceNode({
    @required this.url,
    ARKitPhysicsBody physicsBody,
    ARKitLight light,
    Vector3 position,
    Vector3 scale,
    Vector3 eulerAngles,
    String name,
    int renderingOrder,
    bool isHidden,
  }) : super(
          physicsBody: physicsBody,
          light: light,
          position: position,
          scale: scale,
          eulerAngles: eulerAngles,
          name: name,
          renderingOrder: renderingOrder,
          isHidden: isHidden,
        );

  /// URL location of the Node
  /// Defaults to path from Main Bundle
  /// If path from main bundle fails, will search as full file path
  final String url;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'url': url,
      }..addAll(super.toMap());
}
