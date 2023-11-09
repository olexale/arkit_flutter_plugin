import 'package:vector_math/vector_math_64.dart';

import '../arkit_plugin.dart';

///  Node for ar drawing.
class ARKitLineNode extends ARKitNode {
  ARKitLineNode({
    this.radius = 0.01,
    this.edges = 12,
    this.maxTurning =  12,
    this.materials,
    ARKitPhysicsBody? physicsBody,
    ARKitLight? light,
    Vector3? position,
    Vector3? scale,
    Vector3? eulerAngles,
    String? name,
    int renderingOrder = ARKitNode.defaultRenderingOrderValue,
    bool isHidden = ARKitNode.defaultIsHiddenValue,
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
  final List<ARKitMaterial>? materials;
  final double radius;
  final int edges;
  final int maxTurning;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'materials' :  materials?.map((e) => e.toJson()).toList(),
        'radius': radius,
        'edges': edges,
        'maxTurning': maxTurning
      }..addAll(super.toMap());
}
