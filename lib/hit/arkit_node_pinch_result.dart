import 'package:json_annotation/json_annotation.dart';

part 'arkit_node_pinch_result.g.dart';

/// The result of users pinch gesture interaction with nodes
@JsonSerializable()
class ARKitNodePinchResult {
  const ARKitNodePinchResult(this.nodeName, this.scale);

  /// The name of the node which users is interacting with.
  final String nodeName;

  // The pinch scale value.
  final double scale;

  static ARKitNodePinchResult fromJson(Map<String, dynamic> json) =>
      _$ARKitNodePinchResultFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitNodePinchResultToJson(this);
}
