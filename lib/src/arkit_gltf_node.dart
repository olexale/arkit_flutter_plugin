import 'package:arkit_plugin/src/arkit_node.dart';
import 'package:arkit_plugin/src/enums/asset_type.dart';

/// Node in .gltf or .glb file format.
class ARKitGltfNode extends ARKitNode {
  ARKitGltfNode({
    this.assetType = AssetType.documents,
    required this.url,
    super.physicsBody,
    super.light,
    super.position,
    super.scale,
    super.eulerAngles,
    super.name,
    super.renderingOrder,
    super.isHidden,
  });

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
