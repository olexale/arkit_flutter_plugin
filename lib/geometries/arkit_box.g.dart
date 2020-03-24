// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitBox _$ARKitBoxFromJson(Map<String, dynamic> json) {
  return ARKitBox(
    width: (json['width'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
    length: (json['length'] as num).toDouble(),
    chamferRadius: (json['chamferRadius'] as num).toDouble(),
    materials: (json['materials'] as List)
        .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

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
