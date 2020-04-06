// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitLine _$ARKitLineFromJson(Map<String, dynamic> json) {
  return ARKitLine(
    fromVector: const Vector3Converter().fromJson(json['fromVector'] as List),
    toVector: const Vector3Converter().fromJson(json['toVector'] as List),
    materials: (json['materials'] as List)
        .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ARKitLineToJson(ARKitLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  writeNotNull(
      'fromVector', const Vector3Converter().toJson(instance.fromVector));
  writeNotNull('toVector', const Vector3Converter().toJson(instance.toVector));
  return val;
}
