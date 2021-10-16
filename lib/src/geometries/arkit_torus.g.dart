// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_torus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitTorus _$ARKitTorusFromJson(Map json) => ARKitTorus(
      ringRadius: (json['ringRadius'] as num?)?.toDouble() ?? 0.5,
      pipeRadius: (json['pipeRadius'] as num?)?.toDouble() ?? 0.25,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ARKitTorusToJson(ARKitTorus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  writeNotNull('ringRadius',
      const DoubleValueNotifierConverter().toJson(instance.ringRadius));
  writeNotNull('pipeRadius',
      const DoubleValueNotifierConverter().toJson(instance.pipeRadius));
  return val;
}
