// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitMaterial _$ARKitMaterialFromJson(Map<String, dynamic> json) {
  return ARKitMaterial(
    diffuse:
        ARKitMaterialProperty.fromJson(json['diffuse'] as Map<String, dynamic>),
    ambient:
        ARKitMaterialProperty.fromJson(json['ambient'] as Map<String, dynamic>),
    specular: ARKitMaterialProperty.fromJson(
        json['specular'] as Map<String, dynamic>),
    emission: ARKitMaterialProperty.fromJson(
        json['emission'] as Map<String, dynamic>),
    transparent: ARKitMaterialProperty.fromJson(
        json['transparent'] as Map<String, dynamic>),
    reflective: ARKitMaterialProperty.fromJson(
        json['reflective'] as Map<String, dynamic>),
    multiply: ARKitMaterialProperty.fromJson(
        json['multiply'] as Map<String, dynamic>),
    normal:
        ARKitMaterialProperty.fromJson(json['normal'] as Map<String, dynamic>),
    displacement: ARKitMaterialProperty.fromJson(
        json['displacement'] as Map<String, dynamic>),
    ambientOcclusion: ARKitMaterialProperty.fromJson(
        json['ambientOcclusion'] as Map<String, dynamic>),
    selfIllumination: ARKitMaterialProperty.fromJson(
        json['selfIllumination'] as Map<String, dynamic>),
    metalness: ARKitMaterialProperty.fromJson(
        json['metalness'] as Map<String, dynamic>),
    roughness: ARKitMaterialProperty.fromJson(
        json['roughness'] as Map<String, dynamic>),
    shininess: (json['shininess'] as num).toDouble(),
    transparency: (json['transparency'] as num).toDouble(),
    lightingModelName: const ARKitLightingModelConverter()
        .fromJson(json['lightingModelName'] as int),
    fillMode: const ARKitFillModeConverter().fromJson(json['fillMode'] as int),
    cullMode: const ARKitCullModeConverter().fromJson(json['cullMode'] as int),
    transparencyMode: const ARKitTransparencyModeConverter()
        .fromJson(json['transparencyMode'] as int),
    locksAmbientWithDiffuse: json['locksAmbientWithDiffuse'] as bool,
    writesToDepthBuffer: json['writesToDepthBuffer'] as bool,
    colorBufferWriteMask: const ARKitColorMaskConverter()
        .fromJson(json['colorBufferWriteMask'] as int),
    doubleSided: json['doubleSided'] as bool,
    blendMode:
        const ARKitBlendModeConverter().fromJson(json['blendMode'] as int),
  );
}

Map<String, dynamic> _$ARKitMaterialToJson(ARKitMaterial instance) {
  final val = <String, dynamic>{
    'diffuse': instance.diffuse,
    'ambient': instance.ambient,
    'specular': instance.specular,
    'emission': instance.emission,
    'transparent': instance.transparent,
    'reflective': instance.reflective,
    'multiply': instance.multiply,
    'normal': instance.normal,
    'displacement': instance.displacement,
    'ambientOcclusion': instance.ambientOcclusion,
    'selfIllumination': instance.selfIllumination,
    'metalness': instance.metalness,
    'roughness': instance.roughness,
    'shininess': instance.shininess,
    'transparency': instance.transparency,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lightingModelName',
      const ARKitLightingModelConverter().toJson(instance.lightingModelName));
  writeNotNull(
      'fillMode', const ARKitFillModeConverter().toJson(instance.fillMode));
  writeNotNull(
      'cullMode', const ARKitCullModeConverter().toJson(instance.cullMode));
  writeNotNull('transparencyMode',
      const ARKitTransparencyModeConverter().toJson(instance.transparencyMode));
  val['locksAmbientWithDiffuse'] = instance.locksAmbientWithDiffuse;
  val['writesToDepthBuffer'] = instance.writesToDepthBuffer;
  writeNotNull('colorBufferWriteMask',
      const ARKitColorMaskConverter().toJson(instance.colorBufferWriteMask));
  writeNotNull(
      'blendMode', const ARKitBlendModeConverter().toJson(instance.blendMode));
  val['doubleSided'] = instance.doubleSided;
  return val;
}
