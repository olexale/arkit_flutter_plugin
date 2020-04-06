// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_skeleton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitSkeleton _$ARKitSkeletonFromJson(Map<String, dynamic> json) {
  return ARKitSkeleton(
    const MapOfMatrixConverter()
        .fromJson(json['modelTransforms'] as Map<dynamic, List<dynamic>>),
    const MapOfMatrixConverter()
        .fromJson(json['localTransforms'] as Map<dynamic, List<dynamic>>),
  );
}

Map<String, dynamic> _$ARKitSkeletonToJson(ARKitSkeleton instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('modelTransforms',
      const MapOfMatrixConverter().toJson(instance.modelTransforms));
  writeNotNull('localTransforms',
      const MapOfMatrixConverter().toJson(instance.localTransforms));
  return val;
}
