// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_node_pinch_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitNodePinchResult _$ARKitNodePinchResultFromJson(Map json) =>
    ARKitNodePinchResult(
      json['nodeName'] as String?,
      (json['scale'] as num).toDouble(),
    );

Map<String, dynamic> _$ARKitNodePinchResultToJson(
    ARKitNodePinchResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  val['scale'] = instance.scale;
  return val;
}
