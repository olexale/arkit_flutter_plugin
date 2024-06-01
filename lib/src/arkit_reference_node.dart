import 'package:arkit_plugin/src/arkit_node.dart';

///  Node that references an external serialized node graph.
class ARKitReferenceNode extends ARKitNode {
  ARKitReferenceNode({
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

  /// URL location of the Node
  /// Defaults to path from Main Bundle
  /// If path from main bundle fails, will search as full file path
  final String url;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'url': url,
      }..addAll(super.toMap());
}
