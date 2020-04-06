import 'package:json_annotation/json_annotation.dart';

part 'arkit_node_rotation_result.g.dart';

/// The result of users pinch gesture interaction with nodes
@JsonSerializable()
class ARKitNodeRotationResult {
  const ARKitNodeRotationResult(this.nodeName, this.rotation);

  /// The name of the node which users is interacting with.
  final String nodeName;

  // The rotation value.
  final double rotation;

  static ARKitNodeRotationResult fromJson(Map<String, dynamic> json) =>
      _$ARKitNodeRotationResultFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitNodeRotationResultToJson(this);
}
