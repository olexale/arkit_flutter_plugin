// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_physics_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPhysicsBody _$ARKitPhysicsBodyFromJson(Map json) => ARKitPhysicsBody(
      const ARKitPhysicsBodyTypeConverter().fromJson(json['type'] as int),
      shape: _$JsonConverterFromJson<Map<dynamic, dynamic>, ARKitPhysicsShape?>(
          json['shape'], const ARKitPhysicsShapeConverter().fromJson),
      categoryBitMask: json['categoryBitMask'] as int?,
    );

Map<String, dynamic> _$ARKitPhysicsBodyToJson(ARKitPhysicsBody instance) {
  final val = <String, dynamic>{
    'type': const ARKitPhysicsBodyTypeConverter().toJson(instance.type),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'shape', const ARKitPhysicsShapeConverter().toJson(instance.shape));
  writeNotNull('categoryBitMask', instance.categoryBitMask);
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
