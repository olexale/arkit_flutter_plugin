// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_physics_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPhysicsBody _$ARKitPhysicsBodyFromJson(Map<String, dynamic> json) {
  return ARKitPhysicsBody(
    const ARKitPhysicsBodyTypeConverter().fromJson(json['type'] as int),
    shape: json['shape'] == null
        ? null
        : ARKitPhysicsShape.fromJson(json['shape'] as Map<String, dynamic>),
    categoryBitMask: json['categoryBitMask'] as int?,
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
  writeNotNull('shape', instance.shape);
  writeNotNull('categoryBitMask', instance.categoryBitMask);
  return val;
}
