import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

part 'arkit_node_pan_result.g.dart';

/// The result of users pan gesture interaction with nodes
@JsonSerializable()
class ARKitNodePanResult {
  const ARKitNodePanResult(this.nodeName, this.translation);

  /// The name of the node which users is interacting with.
  final String nodeName;

  // The translation in the coordinate system of the scene view
  @Vector2Converter()
  final Vector2 translation;

  static ARKitNodePanResult fromJson(Map<String, dynamic> json) =>
      _$ARKitNodePanResultFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitNodePanResultToJson(this);
}
