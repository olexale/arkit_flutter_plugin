// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_light.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitLight _$ARKitLightFromJson(Map<String, dynamic> json) {
  return ARKitLight(
    type: const ARKitLightTypeConverter().fromJson(json['type'] as int),
    color: const ColorConverter().fromJson(json['color'] as int),
    temperature: (json['temperature'] as num).toDouble(),
    intensity: (json['intensity'] as num).toDouble(),
    spotInnerAngle: (json['spotInnerAngle'] as num).toDouble(),
    spotOuterAngle: (json['spotOuterAngle'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ARKitLightToJson(ARKitLight instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', const ARKitLightTypeConverter().toJson(instance.type));
  writeNotNull('color', const ColorConverter().toJson(instance.color));
  val['temperature'] = instance.temperature;
  writeNotNull('intensity',
      const DoubleValueNotifierConverter().toJson(instance.intensity));
  val['spotInnerAngle'] = instance.spotInnerAngle;
  val['spotOuterAngle'] = instance.spotOuterAngle;
  return val;
}
