import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'arkit_geometry.g.dart';

/// ARKitGeometry is an abstract class that represents the geometry that can be attached to a SCNNode.
abstract class ARKitGeometry {
  ARKitGeometry({@required List<ARKitMaterial> materials})
      : materials = ValueNotifier(materials);

  factory ARKitGeometry.fromJson(Map<String, dynamic> arguments) {
    final type = arguments['geometryType'].toString();
    switch (type) {
      case 'box':
        return ARKitBox.fromJson(arguments);
      case 'capsule':
        return ARKitCapsule.fromJson(arguments);
      case 'cone':
        return ARKitCone.fromJson(arguments);
      case 'cylinder':
        return ARKitCylinder.fromJson(arguments);
      case 'face':
        return ARKitFace.fromJson(arguments);
      case 'line':
        return ARKitLine.fromJson(arguments);
      case 'plane':
        return ARKitPlane.fromJson(arguments);
      case 'pyramid':
        return ARKitPyramid.fromJson(arguments);
      case 'sphere':
        return ARKitSphere.fromJson(arguments);
      case 'text':
        return ARKitText.fromJson(arguments);
      case 'torus':
        return ARKitTorus.fromJson(arguments);
      case 'tube':
        return ARKitTube.fromJson(arguments);
    }
    return ARKitUnkownGeometry.fromJson(arguments);
  }

  /// Specifies the receiver's materials array.
  /// Each geometry element can be rendered using a different material.
  /// The index of the material used for a geometry element is equal to the index of that element modulo the number of materials.
  @ListMaterialsValueNotifierConverter()
  final ValueNotifier<List<ARKitMaterial>> materials;

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class ARKitUnkownGeometry extends ARKitGeometry {
  ARKitUnkownGeometry(this.geometryType);

  final String geometryType;

  static ARKitUnkownGeometry fromJson(Map<String, dynamic> json) =>
      _$ARKitUnkownGeometryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitUnkownGeometryToJson(this);
}
