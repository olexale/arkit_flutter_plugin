import 'package:arkit_plugin/geometries/arkit_anchor.dart';
import 'package:arkit_plugin/hit/arkit_hit_test_result_type.dart';
import 'package:arkit_plugin/utils/matrix4_utils.dart';
import 'package:vector_math/vector_math_64.dart';

/// A result of an intersection found during a hit-test.
class ARKitTestResult {
  ARKitTestResult(
    this.type,
    this.distance,
    this.localTransform,
    this.worldTransform,
    this.anchor,
  );

  /// The type of the hit-test result.
  final ARKitHitTestResultType type;

  /// The distance from the camera to the intersection in meters.
  final double distance;

  /// The transformation matrix that defines the intersection’s rotation, translation and scale
  /// relative to the anchor or nearest feature point.
  final Matrix4 localTransform;

  /// The transformation matrix that defines the intersection’s rotation, translation and scale
  /// relative to the world.
  final Matrix4 worldTransform;

  /// The anchor that the hit-test intersected.
  /// An anchor will only be provided for existing plane result types.
  final ARKitAnchor anchor;

  static ARKitTestResult fromMap(Map<dynamic, dynamic> map) {
    return ARKitTestResult(
      ARKitHitTestResultType.fromNumber(map['type']),
      map['distance'],
      getMatrixFromString(map['localTransform']),
      getMatrixFromString(map['worldTransform']),
      map['anchor'] != null ? ARKitAnchor.fromMap(map['anchor']) : null,
    );
  }
}
