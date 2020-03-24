// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_physics_shape.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPhysicsShape _$ARKitPhysicsShapeFromJson(Map<String, dynamic> json) {
  return ARKitPhysicsShape(
    const ARKitGeometryConverter().fromJson(json['geometry'] as Map),
  );
}

Map<String, dynamic> _$ARKitPhysicsShapeToJson(ARKitPhysicsShape instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'geometry', const ARKitGeometryConverter().toJson(instance.geometry));
  return val;
}
