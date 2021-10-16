import 'package:arkit_plugin/src/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/src/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/src/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_text.g.dart';

/// Represents a block of text that has been extruded.
@JsonSerializable()
class ARKitText extends ARKitGeometry {
  ARKitText({
    required String text,
    required this.extrusionDepth,
    List<ARKitMaterial>? materials,
  })  : text = ValueNotifier(text),
        super(
          materials: materials,
        );

  /// The text to be represented.
  @StringValueNotifierConverter()
  final ValueNotifier<String> text;

  /// The extrusion depth.
  /// If the value is 0, we get a mono-sided, 2D version of the text.
  final double extrusionDepth;

  static ARKitText fromJson(Map<String, dynamic> json) =>
      _$ARKitTextFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitTextToJson(this)..addAll({'dartType': 'ARKitText'});
}
