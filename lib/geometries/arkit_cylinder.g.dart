// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_cylinder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitCylinder _$ARKitCylinderFromJson(Map<String, dynamic> json) {
  return ARKitCylinder(
    height: (json['height'] as num).toDouble(),
    radius: (json['radius'] as num).toDouble(),
    materials: (json['materials'] as List)
        .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

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
