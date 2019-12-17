// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_light_estimate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitLightEstimate _$ARKitLightEstimateFromJson(Map<String, dynamic> json) {
  return ARKitLightEstimate(
    ambientIntensity: (json['ambientIntensity'] as num).toDouble(),
    ambientColorTemperature:
        (json['ambientColorTemperature'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ARKitLightEstimateToJson(ARKitLightEstimate instance) =>
    <String, dynamic>{
      'ambientIntensity': instance.ambientIntensity,
      'ambientColorTemperature': instance.ambientColorTemperature,
    };
