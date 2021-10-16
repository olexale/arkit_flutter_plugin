// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitBox _$ARKitBoxFromJson(Map json) => ARKitBox(
      width: (json['width'] as num?)?.toDouble() ?? 1,
      height: (json['height'] as num?)?.toDouble() ?? 1,
      length: (json['length'] as num?)?.toDouble() ?? 1,
      chamferRadius: (json['chamferRadius'] as num?)?.toDouble() ?? 0,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ARKitBoxToJson(ARKitBox instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  writeNotNull(
      'width', const DoubleValueNotifierConverter().toJson(instance.width));
  writeNotNull(
      'height', const DoubleValueNotifierConverter().toJson(instance.height));
  writeNotNull(
      'length', const DoubleValueNotifierConverter().toJson(instance.length));
  val['chamferRadius'] = instance.chamferRadius;
  return val;
}
