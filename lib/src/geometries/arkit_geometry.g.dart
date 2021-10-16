// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitUnkownGeometry _$ARKitUnkownGeometryFromJson(Map json) =>
    ARKitUnkownGeometry(
      json['geometryType'] as String?,
    );

Map<String, dynamic> _$ARKitUnkownGeometryToJson(ARKitUnkownGeometry instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('geometryType', instance.geometryType);
  return val;
}
