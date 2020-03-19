// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_anchor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitUnkownAnchor _$ARKitUnkownAnchorFromJson(Map<String, dynamic> json) {
  return ARKitUnkownAnchor(
    json['anchorType'] as String,
    json['nodeName'] as String,
    json['identifier'] as String,
    const Matrix4Converter().fromJson(json['transform'] as List<double>),
  );
}

Map<String, dynamic> _$ARKitUnkownAnchorToJson(ARKitUnkownAnchor instance) {
  final val = <String, dynamic>{
    'nodeName': instance.nodeName,
    'identifier': instance.identifier,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'transform', const Matrix4Converter().toJson(instance.transform));
  val['anchorType'] = instance.anchorType;
  return val;
}

ARKitPlaneAnchor _$ARKitPlaneAnchorFromJson(Map<String, dynamic> json) {
  return ARKitPlaneAnchor(
    const Vector3Converter().fromJson(json['center'] as List<double>),
    const Vector3Converter().fromJson(json['extent'] as List<double>),
    json['nodeName'] as String,
    json['identifier'] as String,
    const Matrix4Converter().fromJson(json['transform'] as List<double>),
  );
}

Map<String, dynamic> _$ARKitPlaneAnchorToJson(ARKitPlaneAnchor instance) {
  final val = <String, dynamic>{
    'nodeName': instance.nodeName,
    'identifier': instance.identifier,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'transform', const Matrix4Converter().toJson(instance.transform));
  writeNotNull('center', const Vector3Converter().toJson(instance.center));
  writeNotNull('extent', const Vector3Converter().toJson(instance.extent));
  return val;
}

ARKitImageAnchor _$ARKitImageAnchorFromJson(Map<String, dynamic> json) {
  return ARKitImageAnchor(
    json['referenceImageName'] as String,
    const Vector2Converter()
        .fromJson(json['referenceImagePhysicalSize'] as List<double>),
    json['isTracked'] as bool,
    json['nodeName'] as String,
    json['identifier'] as String,
    const Matrix4Converter().fromJson(json['transform'] as List<double>),
  );
}

Map<String, dynamic> _$ARKitImageAnchorToJson(ARKitImageAnchor instance) {
  final val = <String, dynamic>{
    'nodeName': instance.nodeName,
    'identifier': instance.identifier,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'transform', const Matrix4Converter().toJson(instance.transform));
  val['referenceImageName'] = instance.referenceImageName;
  writeNotNull('referenceImagePhysicalSize',
      const Vector2Converter().toJson(instance.referenceImagePhysicalSize));
  val['isTracked'] = instance.isTracked;
  return val;
}
