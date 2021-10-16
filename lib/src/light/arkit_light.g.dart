// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_light.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitLight _$ARKitLightFromJson(Map json) => ARKitLight(
      type: json['type'] == null
          ? ARKitLightType.omni
          : const ARKitLightTypeConverter().fromJson(json['type'] as int),
      color: json['color'] == null
          ? Colors.white
          : const NullableColorConverter().fromJson(json['color'] as int?),
      temperature: (json['temperature'] as num?)?.toDouble() ?? 6500,
      intensity: (json['intensity'] as num?)?.toDouble(),
      spotInnerAngle: (json['spotInnerAngle'] as num?)?.toDouble() ?? 0,
      spotOuterAngle: (json['spotOuterAngle'] as num?)?.toDouble() ?? 45,
    );

Map<String, dynamic> _$ARKitLightToJson(ARKitLight instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', const ARKitLightTypeConverter().toJson(instance.type));
  writeNotNull('color', const NullableColorConverter().toJson(instance.color));
  val['temperature'] = instance.temperature;
  writeNotNull('intensity',
      const DoubleValueNotifierConverter().toJson(instance.intensity));
  val['spotInnerAngle'] = instance.spotInnerAngle;
  val['spotOuterAngle'] = instance.spotOuterAngle;
  return val;
}
