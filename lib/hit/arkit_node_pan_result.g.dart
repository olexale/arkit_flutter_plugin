// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_node_pan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitNodePanResult _$ARKitNodePanResultFromJson(Map<String, dynamic> json) {
  return ARKitNodePanResult(
    json['nodeName'] as String,
    const Vector2Converter().fromJson(json['translation'] as List),
  );
}

Map<String, dynamic> _$ARKitNodePanResultToJson(ARKitNodePanResult instance) {
  final val = <String, dynamic>{
    'nodeName': instance.nodeName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'translation', const Vector2Converter().toJson(instance.translation));
  return val;
}
