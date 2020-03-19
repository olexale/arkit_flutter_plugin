import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

part 'arkit_skeleton.g.dart';

@JsonSerializable()
class ARKitSkeleton {
  ARKitSkeleton(this.modelTransforms, this.localTransforms);

  /// The model space transforms for each joint
  @MapOfMatrixConverter()
  final Map<String, Matrix4> modelTransforms;

  /// The local space transforms for each joint
  @MapOfMatrixConverter()
  final Map<String, Matrix4> localTransforms;

  static ARKitSkeleton fromJson(Map<String, dynamic> json) =>
      _$ARKitSkeletonFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitSkeletonToJson(this);
}
