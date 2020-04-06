import 'package:arkit_plugin/geometries/arkit_anchor.dart';
import 'package:arkit_plugin/hit/arkit_hit_test_result_type.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

part 'arkit_hit_test_result.g.dart';

/// A result of an intersection found during a hit-test.
@JsonSerializable()
class ARKitTestResult {
  ARKitTestResult(
    this.type,
    this.distance,
    this.localTransform,
    this.worldTransform,
    this.anchor,
  );

  /// The type of the hit-test result.
  @ARKitHitTestResultTypeConverter()
  final ARKitHitTestResultType type;

  /// The distance from the camera to the intersection in meters.
  final double distance;

  /// The transformation matrix that defines the intersection’s rotation, translation and scale
  /// relative to the anchor or nearest feature point.
  @MatrixConverter()
  final Matrix4 localTransform;

  /// The transformation matrix that defines the intersection’s rotation, translation and scale
  /// relative to the world.
  @MatrixConverter()
  final Matrix4 worldTransform;

  /// The anchor that the hit-test intersected.
  /// An anchor will only be provided for existing plane result types.
  @ARKitAnchorConverter()
  final ARKitAnchor anchor;

  static ARKitTestResult fromJson(Map<String, dynamic> json) =>
      _$ARKitTestResultFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitTestResultToJson(this);
}
