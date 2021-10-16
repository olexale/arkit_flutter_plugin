// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_cone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitCone _$ARKitConeFromJson(Map json) => ARKitCone(
      height: (json['height'] as num?)?.toDouble() ?? 1,
      topRadius: (json['topRadius'] as num?)?.toDouble() ?? 0,
      bottomRadius: (json['bottomRadius'] as num?)?.toDouble() ?? 0.5,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ARKitConeToJson(ARKitCone instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  writeNotNull(
      'height', const DoubleValueNotifierConverter().toJson(instance.height));
  writeNotNull('topRadius',
      const DoubleValueNotifierConverter().toJson(instance.topRadius));
  writeNotNull('bottomRadius',
      const DoubleValueNotifierConverter().toJson(instance.bottomRadius));
  return val;
}
