import 'package:flutter/widgets.dart';

/// The contents of a ARKitMaterial slot
/// This can be used to specify the various properties of SCNMaterial slots such as diffuse, ambient, etc.
class ARKitMaterialProperty {
  ARKitMaterialProperty({this.color});
  final Color color;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'color': color.value,
      };
}

/// An ARKitMaterial determines how a geometry is rendered.
/// It encapsulates the colors and textures that define the appearance of 3d geometries.
class ARKitMaterial {
  ARKitMaterial({this.diffuse});

  /// Specifies the receiver's diffuse property.
  /// The diffuse property specifies the amount of light diffusely reflected
  /// from the surface. The diffuse light is reflected equally in all directions and is
  /// therefore independent of the point of view.
  final ARKitMaterialProperty diffuse;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'diffuse': diffuse.toMap(),
      };
}
