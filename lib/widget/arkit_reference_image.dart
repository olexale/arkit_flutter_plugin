import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_reference_image.g.dart';

@JsonSerializable()
class ARKitReferenceImage {
  const ARKitReferenceImage({
    this.name,
    this.url,
    this.physicalSize,
  });

  /// An image name for local images (optional)
  final String name;

  /// An URI to the image (optional)
  final String url;

  /// The physical size of the image in meters.
  @SizeTypeConverter()
  final Size physicalSize;

  static ARKitReferenceImage fromMap(Map<String, double> map) =>
      _$ARKitReferenceImageFromJson(map);

  Map<String, dynamic> toMap() => _$ARKitReferenceImageToJson(this);
}
