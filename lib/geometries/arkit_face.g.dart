// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_face.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitFace _$ARKitFaceFromJson(Map<String, dynamic> json) {
  return ARKitFace(
    materials: (json['materials'] as List)
        .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ARKitFaceToJson(ARKitFace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  return val;
}
