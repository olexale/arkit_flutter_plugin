// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_node_pinch_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitNodePinchResult _$ARKitNodePinchResultFromJson(Map<String, dynamic> json) {
  return ARKitNodePinchResult(
    json['nodeName'] as String,
    (json['scale'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ARKitNodePinchResultToJson(
        ARKitNodePinchResult instance) =>
    <String, dynamic>{
      'nodeName': instance.nodeName,
      'scale': instance.scale,
    };
