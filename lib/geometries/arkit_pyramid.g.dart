// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_pyramid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPyramid _$ARKitPyramidFromJson(Map<String, dynamic> json) {
  return ARKitPyramid(
    height: (json['height'] as num).toDouble(),
    width: (json['width'] as num).toDouble(),
    length: (json['length'] as num).toDouble(),
    materials: (json['materials'] as List)
        .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ARKitPyramidToJson(ARKitPyramid instance) {
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
      'width', const DoubleValueNotifierConverter().toJson(instance.width));
  writeNotNull(
      'length', const DoubleValueNotifierConverter().toJson(instance.length));
  return val;
}
