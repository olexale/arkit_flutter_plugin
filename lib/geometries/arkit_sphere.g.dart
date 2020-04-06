// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_sphere.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitSphere _$ARKitSphereFromJson(Map<String, dynamic> json) {
  return ARKitSphere(
    radius: (json['radius'] as num).toDouble(),
    materials: (json['materials'] as List)
        .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ARKitSphereToJson(ARKitSphere instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  writeNotNull(
      'radius', const DoubleValueNotifierConverter().toJson(instance.radius));
  return val;
}
