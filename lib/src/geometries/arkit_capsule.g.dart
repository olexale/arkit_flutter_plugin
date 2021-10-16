// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_capsule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitCapsule _$ARKitCapsuleFromJson(Map json) => ARKitCapsule(
      capRadius: (json['capRadius'] as num?)?.toDouble() ?? 0.5,
      height: (json['height'] as num?)?.toDouble() ?? 2,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ARKitCapsuleToJson(ARKitCapsule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  writeNotNull('capRadius',
      const DoubleValueNotifierConverter().toJson(instance.capRadius));
  writeNotNull(
      'height', const DoubleValueNotifierConverter().toJson(instance.height));
  return val;
}
