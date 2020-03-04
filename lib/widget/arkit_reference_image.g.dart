// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_reference_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitReferenceImage _$ARKitReferenceImageFromJson(Map<String, dynamic> json) {
  return ARKitReferenceImage(
    name: json['name'] as String,
    url: json['url'] as String,
    physicalSize: const SizeTypeConverter()
        .fromJson(json['physicalSize'] as Map<String, double>),
  );
}

Map<String, dynamic> _$ARKitReferenceImageToJson(ARKitReferenceImage instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'url': instance.url,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'physicalSize', const SizeTypeConverter().toJson(instance.physicalSize));
  return val;
}
