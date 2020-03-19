// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_physics_shape.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPhysicsShape _$ARKitPhysicsShapeFromJson(Map<String, dynamic> json) {
  return ARKitPhysicsShape(
    ARKitGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ARKitPhysicsShapeToJson(ARKitPhysicsShape instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
    };
