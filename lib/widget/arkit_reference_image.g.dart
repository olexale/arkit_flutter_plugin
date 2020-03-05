// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_reference_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitReferenceImage _$ARKitReferenceImageFromJson(Map<String, dynamic> json) {
  return ARKitReferenceImage(
    name: json['name'] as String,
    physicalWidth: (json['physicalWidth'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ARKitReferenceImageToJson(
        ARKitReferenceImage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'physicalWidth': instance.physicalWidth,
    };
