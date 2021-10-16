import 'package:arkit_plugin/src/enums/arkit_skeleton_joint_name.dart';
import 'package:arkit_plugin/src/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

part 'arkit_skeleton.g.dart';

/// Definition of a skeleton.
/// A skeleton consists of a set of labeled joints that are defined in a certain hierarchy, i.e. joints are parented to other joints.
/// One may use the parentIndices property to identify the hierarchy for a given skeleton definition.
@JsonSerializable()
class ARKitSkeleton {
  ARKitSkeleton(this.modelTransforms, this.localTransforms);

  /// The model space transforms for each joint
  @MapOfMatrixConverter()
  final Map<String, Matrix4> modelTransforms;

  /// The local space transforms for each joint
  @MapOfMatrixConverter()
  final Map<String, Matrix4> localTransforms;

  /// The joint names.
  Iterable<String> get jointNames => modelTransforms.keys;

  /// The number of joints.
  int get jointCount => modelTransforms.length;

  Matrix4? modelTransformsFor(ARKitSkeletonJointName joint) =>
      modelTransforms[joint.toJointNameString()];

  Matrix4? localTransformsFor(ARKitSkeletonJointName joint) =>
      localTransforms[joint.toJointNameString()];

  static ARKitSkeleton fromJson(Map json) => _$ARKitSkeletonFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitSkeletonToJson(this);
}
