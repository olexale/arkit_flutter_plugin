// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_hit_test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitTestResult _$ARKitTestResultFromJson(Map json) => ARKitTestResult(
      const ARKitHitTestResultTypeConverter().fromJson(json['type'] as int),
      (json['distance'] as num).toDouble(),
      const MatrixConverter().fromJson(json['localTransform'] as List),
      const MatrixConverter().fromJson(json['worldTransform'] as List),
      const ARKitAnchorConverter().fromJson(json['anchor'] as Map?),
    );

Map<String, dynamic> _$ARKitTestResultToJson(ARKitTestResult instance) {
  final val = <String, dynamic>{
    'type': const ARKitHitTestResultTypeConverter().toJson(instance.type),
    'distance': instance.distance,
    'localTransform': const MatrixConverter().toJson(instance.localTransform),
    'worldTransform': const MatrixConverter().toJson(instance.worldTransform),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('anchor', const ARKitAnchorConverter().toJson(instance.anchor));
  return val;
}
