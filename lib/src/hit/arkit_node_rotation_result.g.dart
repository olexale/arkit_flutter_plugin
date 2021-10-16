// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_node_rotation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitNodeRotationResult _$ARKitNodeRotationResultFromJson(Map json) =>
    ARKitNodeRotationResult(
      json['nodeName'] as String?,
      (json['rotation'] as num).toDouble(),
    );

Map<String, dynamic> _$ARKitNodeRotationResultToJson(
    ARKitNodeRotationResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  val['rotation'] = instance.rotation;
  return val;
}
