import 'dart:ui';

import 'package:arkit_plugin/src/utils/json_converters.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_material_property.g.dart';

/// The contents of a ARKitMaterial slot
/// This can be used to specify the various properties of SCNMaterial slots such as diffuse, ambient, etc.
abstract class ARKitMaterialProperty {
  const ARKitMaterialProperty._(this.type);

  /// Specifies the receiver's color.
  static ARKitMaterialColor color(Color color) => ARKitMaterialColor(color);

  /// Specifies the receiver's image.
  /// It might be either a name of an image stored in native iOS project or
  /// a full path to the file in the Flutter folder (/assets/image/img.jpg)
  /// or URL
  /// or base64 string (highly not recommended due to potential performance issues)
  static ARKitMaterialImage image(String image) => ARKitMaterialImage(image);

  /// Floating value between 0 and 1 (NSNumber) for metalness and roughness properties
  static ARKitMaterialValue value(double value) => ARKitMaterialValue(value);

  /// Specifies the receiver's video.
  static ARKitMaterialVideo video({
    required int width,
    required int height,
    String? filename,
    String? url,
    bool? autoplay = true,
  }) =>
      ARKitMaterialVideo(
        filename: filename,
        url: url,
        width: width,
        height: height,
        autoplay: autoplay ?? true,
      );

  final String type;

  static ARKitMaterialProperty fromJson(Map<String, dynamic> json) {
    final type = json['type'].toString();
    switch (type) {
      case 'color':
        return ARKitMaterialColor.fromJson(json);
      case 'image':
        return ARKitMaterialImage.fromJson(json);
      case 'value':
        return ARKitMaterialValue.fromJson(json);
      case 'video':
        return ARKitMaterialVideo.fromJson(json);
    }
    throw Exception('Could not parse material: $json');
  }

  Map<String, dynamic> toJson();
}

/// Specifies the receiver's color.
@JsonSerializable()
class ARKitMaterialColor extends ARKitMaterialProperty {
  const ARKitMaterialColor(this.color) : super._('color');

  @ColorConverter()
  final Color color;

  static ARKitMaterialColor fromJson(Map<String, dynamic> json) =>
      _$ARKitMaterialColorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitMaterialColorToJson(this);
}

/// Specifies the receiver's image.
/// It might be either a name of an image stored in native iOS project or
/// a full path to the file in the Flutter folder (/assets/image/img.jpg)
/// or URL
/// or base64 string (highly not recommended due to potential performance issues)
@JsonSerializable()
class ARKitMaterialImage extends ARKitMaterialProperty {
  const ARKitMaterialImage(this.image) : super._('image');

  final String image;

  static ARKitMaterialImage fromJson(Map<String, dynamic> json) =>
      _$ARKitMaterialImageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitMaterialImageToJson(this);
}

/// Floating value between 0 and 1 (NSNumber) for metalness and roughness properties
@JsonSerializable()
class ARKitMaterialValue extends ARKitMaterialProperty {
  const ARKitMaterialValue(this.value) : super._('value');

  final double value;

  static ARKitMaterialValue fromJson(Map<String, dynamic> json) =>
      _$ARKitMaterialValueFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitMaterialValueToJson(this);
}

/// Specifies the receiver's video.
/// Initializes a video using a video file stored in the app bundle or using a URL.
@JsonSerializable()
class ARKitMaterialVideo extends ARKitMaterialProperty {
  ARKitMaterialVideo({
    required this.width,
    required this.height,
    this.autoplay = true,
    this.filename,
    this.url,
  })  : id = UniqueKey().toString(),
        super._('video');

  final String? filename;
  final String? url;
  final int width;
  final int height;
  final bool autoplay;

  final String id;

  static const MethodChannel _channel = MethodChannel('arkit_video_playback');

  void dispose() {
    _channel.invokeMethod<void>('dispose', {'id': id});
  }

  /// Starts video playback.
  Future<void> play() => _channel.invokeMethod<void>('play', {'id': id});

  /// Pauses video playback.
  Future<void> pause() => _channel.invokeMethod<void>('pause', {'id': id});

  static ARKitMaterialVideo fromJson(Map<String, dynamic> json) =>
      _$ARKitMaterialVideoFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitMaterialVideoToJson(this)..addAll({'id': id});
}
