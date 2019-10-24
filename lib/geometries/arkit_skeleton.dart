import 'package:arkit_plugin/utils/matrix4_utils.dart';
import 'package:vector_math/vector_math_64.dart';

class ARKitSkeleton {
  ARKitSkeleton(this.modelTransforms, this.localTransforms);

  /// The model space transforms for each joint
  final Map<String, Matrix4> modelTransforms;

  /// The local space transforms for each joint
  final Map<String, Matrix4> localTransforms;

  static ARKitSkeleton fromMap(Map<String, dynamic> map) => ARKitSkeleton(
        _convertMapOfStrings(
            map.cast<String, Map>()['modelTransforms'].cast<String, dynamic>()),
        _convertMapOfStrings(
            map.cast<String, Map>()['localTransforms'].cast<String, dynamic>()),
      );

  static Map<String, Matrix4> _convertMapOfStrings(Map<String, dynamic> map) {
    return map.map<String, Matrix4>((String key, dynamic value) =>
        MapEntry<String, Matrix4>(key, getMatrixFromString(value)));
  }
}
