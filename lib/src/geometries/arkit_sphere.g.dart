// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_sphere.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitSphere _$ARKitSphereFromJson(Map json) => ARKitSphere(
      radius: (json['radius'] as num?)?.toDouble() ?? 0.5,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

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
