// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_material_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitMaterialColor _$ARKitMaterialColorFromJson(Map json) => ARKitMaterialColor(
      const ColorConverter().fromJson(json['color'] as int),
    );

Map<String, dynamic> _$ARKitMaterialColorToJson(ARKitMaterialColor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('color', const ColorConverter().toJson(instance.color));
  return val;
}

ARKitMaterialImage _$ARKitMaterialImageFromJson(Map json) => ARKitMaterialImage(
      json['image'] as String,
    );

Map<String, dynamic> _$ARKitMaterialImageToJson(ARKitMaterialImage instance) =>
    <String, dynamic>{
      'image': instance.image,
    };

ARKitMaterialValue _$ARKitMaterialValueFromJson(Map json) => ARKitMaterialValue(
      (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$ARKitMaterialValueToJson(ARKitMaterialValue instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

ARKitMaterialVideo _$ARKitMaterialVideoFromJson(Map json) => ARKitMaterialVideo(
      width: json['width'] as int,
      height: json['height'] as int,
      autoplay: json['autoplay'] as bool? ?? true,
      filename: json['filename'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ARKitMaterialVideoToJson(ARKitMaterialVideo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('filename', instance.filename);
  writeNotNull('url', instance.url);
  val['width'] = instance.width;
  val['height'] = instance.height;
  val['autoplay'] = instance.autoplay;
  return val;
}
