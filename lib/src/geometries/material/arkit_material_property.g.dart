// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_material_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitMaterialColor _$ARKitMaterialColorFromJson(Map json) => ARKitMaterialColor(
      const ColorConverter().fromJson((json['color'] as num).toInt()),
    );

Map<String, dynamic> _$ARKitMaterialColorToJson(ARKitMaterialColor instance) =>
    <String, dynamic>{
      'color': const ColorConverter().toJson(instance.color),
    };

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
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      autoplay: json['autoplay'] as bool? ?? true,
      filename: json['filename'] as String?,
      url: json['url'] as String?,
      filePath: json['filePath'] as String?,
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
  writeNotNull('filePath', instance.filePath);
  val['width'] = instance.width;
  val['height'] = instance.height;
  val['autoplay'] = instance.autoplay;
  return val;
}
