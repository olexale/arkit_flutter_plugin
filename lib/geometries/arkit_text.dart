import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Represents a block of text that has been extruded.
class ARKitText extends ARKitGeometry {
  ARKitText({
    @required String text,
    @required this.extrusionDepth,
    List<ARKitMaterial> materials,
  })  : text = ValueNotifier(text),
        super(
          materials: materials,
        );

  /// The text to be represented.
  final ValueNotifier<String> text;

  /// The extrusion depth.
  /// If the value is 0, we get a mono-sided, 2D version of the text.
  final double extrusionDepth;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'text': text.value,
        'extrusionDepth': extrusionDepth,
      }..addAll(super.toMap());
}
