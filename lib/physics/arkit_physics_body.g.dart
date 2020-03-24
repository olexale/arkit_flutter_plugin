// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_physics_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPhysicsBody _$ARKitPhysicsBodyFromJson(Map<String, dynamic> json) {
  return ARKitPhysicsBody(
    const ARKitPhysicsBodyTypeConverter().fromJson(json['type'] as int),
    shape: const ARKitPhysicsShapeConverter().fromJson(json['shape'] as Map),
    categoryBitMask: json['categoryBitMask'] as int,
  );
}

Map<String, dynamic> _$ARKitPhysicsBodyToJson(ARKitPhysicsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'type', const ARKitPhysicsBodyTypeConverter().toJson(instance.type));
  writeNotNull(
      'shape', const ARKitPhysicsShapeConverter().toJson(instance.shape));
  val['categoryBitMask'] = instance.categoryBitMask;
  return val;
}
