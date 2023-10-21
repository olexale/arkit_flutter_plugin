import 'package:arkit_plugin/src/arkit_node.dart';
import 'package:arkit_plugin/src/light/arkit_light.dart';
import 'package:arkit_plugin/src/physics/arkit_physics_body.dart';
import 'package:vector_math/vector_math_64.dart';
import 'enums/asset_type.dart';

/// Node in .gltf or .glb file format.
class ARKitGltfNode extends ARKitNode {
  ARKitGltfNode({
    this.assetType = AssetType.documents,
    required this.url,
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

  /// Path to the asset.
  final String url;

  /// Describes the location of the asset.
  final AssetType assetType;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'url': url,
        'assetType': assetType.index
      }..addAll(super.toMap());
}
