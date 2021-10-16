// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_tube.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitTube _$ARKitTubeFromJson(Map json) => ARKitTube(
      innerRadius: (json['innerRadius'] as num?)?.toDouble() ?? 0.25,
      outerRadius: (json['outerRadius'] as num?)?.toDouble() ?? 0.5,
      height: (json['height'] as num?)?.toDouble() ?? 1,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ARKitTubeToJson(ARKitTube instance) {
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
  writeNotNull('innerRadius',
      const DoubleValueNotifierConverter().toJson(instance.innerRadius));
  writeNotNull('outerRadius',
      const DoubleValueNotifierConverter().toJson(instance.outerRadius));
  return val;
}
