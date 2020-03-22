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
    const MatrixConverter().fromJson(json['transform'] as List),
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

  writeNotNull('transform', const MatrixConverter().toJson(instance.transform));
  val['anchorType'] = instance.anchorType;
  return val;
}

ARKitPlaneAnchor _$ARKitPlaneAnchorFromJson(Map<String, dynamic> json) {
  return ARKitPlaneAnchor(
    const Vector3Converter().fromJson(json['center'] as List),
    const Vector3Converter().fromJson(json['extent'] as List),
    json['nodeName'] as String,
    json['identifier'] as String,
    const MatrixConverter().fromJson(json['transform'] as List),
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

  writeNotNull('transform', const MatrixConverter().toJson(instance.transform));
  writeNotNull('center', const Vector3Converter().toJson(instance.center));
  writeNotNull('extent', const Vector3Converter().toJson(instance.extent));
  return val;
}

ARKitImageAnchor _$ARKitImageAnchorFromJson(Map<String, dynamic> json) {
  return ARKitImageAnchor(
    json['referenceImageName'] as String,
    const Vector2Converter()
        .fromJson(json['referenceImagePhysicalSize'] as List),
    json['isTracked'] as bool,
    json['nodeName'] as String,
    json['identifier'] as String,
    const MatrixConverter().fromJson(json['transform'] as List),
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

  writeNotNull('transform', const MatrixConverter().toJson(instance.transform));
  val['referenceImageName'] = instance.referenceImageName;
  writeNotNull('referenceImagePhysicalSize',
      const Vector2Converter().toJson(instance.referenceImagePhysicalSize));
  val['isTracked'] = instance.isTracked;
  return val;
}

ARKitFaceAnchor _$ARKitFaceAnchorFromJson(Map<String, dynamic> json) {
  return ARKitFaceAnchor(
    Map<String, double>.from(json['blendShapes'] as Map),
    json['isTracked'] as bool,
    json['nodeName'] as String,
    json['identifier'] as String,
    const MatrixConverter().fromJson(json['transform'] as List),
    const MatrixConverter().fromJson(json['leftEyeTransform'] as List),
    const MatrixConverter().fromJson(json['rightEyeTransform'] as List),
  );
}

Map<String, dynamic> _$ARKitFaceAnchorToJson(ARKitFaceAnchor instance) {
  final val = <String, dynamic>{
    'nodeName': instance.nodeName,
    'identifier': instance.identifier,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transform', const MatrixConverter().toJson(instance.transform));
  writeNotNull('leftEyeTransform',
      const MatrixConverter().toJson(instance.leftEyeTransform));
  writeNotNull('rightEyeTransform',
      const MatrixConverter().toJson(instance.rightEyeTransform));
  val['blendShapes'] = instance.blendShapes;
  val['isTracked'] = instance.isTracked;
  return val;
}

ARKitBodyAnchor _$ARKitBodyAnchorFromJson(Map<String, dynamic> json) {
  return ARKitBodyAnchor(
    ARKitSkeleton.fromJson(json['skeleton'] as Map<String, dynamic>),
    json['isTracked'] as bool,
    json['nodeName'] as String,
    json['identifier'] as String,
    const MatrixConverter().fromJson(json['transform'] as List),
  );
}

Map<String, dynamic> _$ARKitBodyAnchorToJson(ARKitBodyAnchor instance) {
  final val = <String, dynamic>{
    'nodeName': instance.nodeName,
    'identifier': instance.identifier,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transform', const MatrixConverter().toJson(instance.transform));
  val['skeleton'] = instance.skeleton;
  val['isTracked'] = instance.isTracked;
  return val;
}
