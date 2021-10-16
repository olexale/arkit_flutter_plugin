// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_pyramid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPyramid _$ARKitPyramidFromJson(Map json) => ARKitPyramid(
      height: (json['height'] as num?)?.toDouble() ?? 1,
      width: (json['width'] as num?)?.toDouble() ?? 1,
      length: (json['length'] as num?)?.toDouble() ?? 1,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

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
