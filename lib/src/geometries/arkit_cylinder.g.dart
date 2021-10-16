// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_cylinder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitCylinder _$ARKitCylinderFromJson(Map json) => ARKitCylinder(
      height: (json['height'] as num?)?.toDouble() ?? 1,
      radius: (json['radius'] as num?)?.toDouble() ?? 0.5,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ARKitCylinderToJson(ARKitCylinder instance) {
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
  writeNotNull(
      'radius', const DoubleValueNotifierConverter().toJson(instance.radius));
  return val;
}
