import 'package:vector_math/vector_math_64.dart';

/// The result of users pan gesture interaction with nodes
class ARKitNodePanResult {
  ARKitNodePanResult._(this.nodeName, this.translation);

  /// The name of the node which users is interacting with.
  final String nodeName;

  // The translation in the coordinate system of the scene view
  final Vector2 translation;

  static ARKitNodePanResult fromMap(Map<dynamic, dynamic> map) =>
      ARKitNodePanResult._(
        map['name'],
        Vector2(map['x'], map['y']),
      );
}
