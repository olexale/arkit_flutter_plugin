/// The result of users pinch gesture interaction with nodes
class ARKitNodePinchResult {
  ARKitNodePinchResult._(this.nodeName, this.scale);

  /// The name of the node which users is interacting with.
  final String nodeName;

  // The pinch scale value.
  final double scale;

  static ARKitNodePinchResult fromMap(Map<dynamic, dynamic> map) =>
      ARKitNodePinchResult._(
        map['name'],
        map['scale'],
      );
}
