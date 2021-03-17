// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_material_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitMaterialProperty _$ARKitMaterialPropertyFromJson(
    Map<String, dynamic> json) {
  return ARKitMaterialProperty(
    color: const ColorConverter().fromJson(json['color'] as int),
    image: json['image'] as String,
    rawImage: ARKitMaterialPropertyImage.fromJson(
        json['rawImage'] as Map<String, dynamic>),
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ARKitMaterialPropertyToJson(
    ARKitMaterialProperty instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('color', const ColorConverter().toJson(instance.color));
  val['image'] = instance.image;
  val['rawImage'] = instance.rawImage;
  val['url'] = instance.url;
  return val;
}

ARKitMaterialPropertyImage _$ARKitMaterialPropertyImageFromJson(
    Map<String, dynamic> json) {
  return ARKitMaterialPropertyImage(
    json['width'] as int,
    json['height'] as int,
    (json['imageBytes'] as List).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$ARKitMaterialPropertyImageToJson(
        ARKitMaterialPropertyImage instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'imageBytes': instance.imageBytes,
    };
