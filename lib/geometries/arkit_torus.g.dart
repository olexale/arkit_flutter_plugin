// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_torus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitTorus _$ARKitTorusFromJson(Map<String, dynamic> json) {
  return ARKitTorus(
    ringRadius: (json['ringRadius'] as num).toDouble(),
    pipeRadius: (json['pipeRadius'] as num).toDouble(),
    materials: (json['materials'] as List)
        .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

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
