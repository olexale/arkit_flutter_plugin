// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_hit_test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitTestResult _$ARKitTestResultFromJson(Map<String, dynamic> json) {
  return ARKitTestResult(
    const ARKitHitTestResultTypeConverter().fromJson(json['type'] as int),
    (json['distance'] as num).toDouble(),
    const MatrixConverter().fromJson(json['localTransform'] as List),
    const MatrixConverter().fromJson(json['worldTransform'] as List),
    const ARKitAnchorConverter().fromJson(json['anchor'] as Map),
  );
}

Map<String, dynamic> _$ARKitTestResultToJson(ARKitTestResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'type', const ARKitHitTestResultTypeConverter().toJson(instance.type));
  val['distance'] = instance.distance;
  writeNotNull('localTransform',
      const MatrixConverter().toJson(instance.localTransform));
  writeNotNull('worldTransform',
      const MatrixConverter().toJson(instance.worldTransform));
  writeNotNull('anchor', const ARKitAnchorConverter().toJson(instance.anchor));
  return val;
}
