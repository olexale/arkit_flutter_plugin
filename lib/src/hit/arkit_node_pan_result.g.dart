// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_node_pan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitNodePanResult _$ARKitNodePanResultFromJson(Map json) => ARKitNodePanResult(
      json['nodeName'] as String?,
      const Vector2Converter().fromJson(json['translation'] as List),
    );

Map<String, dynamic> _$ARKitNodePanResultToJson(ARKitNodePanResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  writeNotNull(
      'translation', const Vector2Converter().toJson(instance.translation));
  return val;
}
