// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitMaterial _$ARKitMaterialFromJson(Map<String, dynamic> json) {
  return ARKitMaterial(
    diffuse:
        const ARKitMaterialPropertyConverter().fromJson(json['diffuse'] as Map),
    ambient:
        const ARKitMaterialPropertyConverter().fromJson(json['ambient'] as Map),
    specular: const ARKitMaterialPropertyConverter()
        .fromJson(json['specular'] as Map),
    emission: const ARKitMaterialPropertyConverter()
        .fromJson(json['emission'] as Map),
    transparent: const ARKitMaterialPropertyConverter()
        .fromJson(json['transparent'] as Map),
    reflective: const ARKitMaterialPropertyConverter()
        .fromJson(json['reflective'] as Map),
    multiply: const ARKitMaterialPropertyConverter()
        .fromJson(json['multiply'] as Map),
    normal:
        const ARKitMaterialPropertyConverter().fromJson(json['normal'] as Map),
    displacement: const ARKitMaterialPropertyConverter()
        .fromJson(json['displacement'] as Map),
    ambientOcclusion: const ARKitMaterialPropertyConverter()
        .fromJson(json['ambientOcclusion'] as Map),
    selfIllumination: const ARKitMaterialPropertyConverter()
        .fromJson(json['selfIllumination'] as Map),
    metalness: const ARKitMaterialPropertyConverter()
        .fromJson(json['metalness'] as Map),
    roughness: const ARKitMaterialPropertyConverter()
        .fromJson(json['roughness'] as Map),
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
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('diffuse',
      const ARKitMaterialPropertyConverter().toJson(instance.diffuse));
  writeNotNull('ambient',
      const ARKitMaterialPropertyConverter().toJson(instance.ambient));
  writeNotNull('specular',
      const ARKitMaterialPropertyConverter().toJson(instance.specular));
  writeNotNull('emission',
      const ARKitMaterialPropertyConverter().toJson(instance.emission));
  writeNotNull('transparent',
      const ARKitMaterialPropertyConverter().toJson(instance.transparent));
  writeNotNull('reflective',
      const ARKitMaterialPropertyConverter().toJson(instance.reflective));
  writeNotNull('multiply',
      const ARKitMaterialPropertyConverter().toJson(instance.multiply));
  writeNotNull(
      'normal', const ARKitMaterialPropertyConverter().toJson(instance.normal));
  writeNotNull('displacement',
      const ARKitMaterialPropertyConverter().toJson(instance.displacement));
  writeNotNull('ambientOcclusion',
      const ARKitMaterialPropertyConverter().toJson(instance.ambientOcclusion));
  writeNotNull('selfIllumination',
      const ARKitMaterialPropertyConverter().toJson(instance.selfIllumination));
  writeNotNull('metalness',
      const ARKitMaterialPropertyConverter().toJson(instance.metalness));
  writeNotNull('roughness',
      const ARKitMaterialPropertyConverter().toJson(instance.roughness));
  val['shininess'] = instance.shininess;
  val['transparency'] = instance.transparency;
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
