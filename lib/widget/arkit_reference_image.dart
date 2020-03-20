import 'package:json_annotation/json_annotation.dart';

part 'arkit_reference_image.g.dart';

/// A reference image to be detected in the scene.
@JsonSerializable()
class ARKitReferenceImage {
  const ARKitReferenceImage({
    this.name,
    this.physicalWidth,
  });

  /// An image name for local images (bundle, asset, or url)
  final String name;

  /// The physical width of the image in meters.
  final double physicalWidth;

  static ARKitReferenceImage fromJson(Map<String, double> map) =>
      _$ARKitReferenceImageFromJson(map);

  Map<String, dynamic> toJson() => _$ARKitReferenceImageToJson(this);
}
