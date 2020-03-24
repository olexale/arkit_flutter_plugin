import 'dart:ui';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin/geometries/arkit_anchor.dart';
import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/material/arkit_blend_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_color_mask.dart';
import 'package:arkit_plugin/geometries/material/arkit_cull_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_fill_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_lighting_model.dart';
import 'package:arkit_plugin/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/geometries/material/arkit_transparency_mode.dart';
import 'package:arkit_plugin/hit/arkit_hit_test_result_type.dart';
import 'package:arkit_plugin/light/arkit_light_type.dart';
import 'package:arkit_plugin/physics/arkit_physics_body_type.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

class DoubleValueNotifierConverter extends ValueNotifierConverter<double> {
  const DoubleValueNotifierConverter() : super();
}

class StringValueNotifierConverter extends ValueNotifierConverter<String> {
  const StringValueNotifierConverter() : super();
}

class ListMaterialsValueNotifierConverter
    implements JsonConverter<ValueNotifier<List<ARKitMaterial>>, List<Map>> {
  const ListMaterialsValueNotifierConverter();

  @override
  ValueNotifier<List<ARKitMaterial>> fromJson(List<Map> json) {
    if (json == null) {
      return null;
    }
    return ValueNotifier(json
        .map((e) => Map<String, dynamic>.from(e))
        .map((e) => ARKitMaterial.fromJson(e)));
  }

  @override
  List<Map> toJson(ValueNotifier<List<ARKitMaterial>> object) {
    if (object.value == null) {
      return null;
    }
    return object.value.map((e) => e.toJson()).toList();
  }
}

class ARKitMaterialPropertyConverter
    implements JsonConverter<ARKitMaterialProperty, Map> {
  const ARKitMaterialPropertyConverter();

  @override
  ARKitMaterialProperty fromJson(Map json) =>
      ARKitMaterialProperty.fromJson(Map<String, dynamic>.from(json));

  @override
  Map toJson(ARKitMaterialProperty object) => object?.toJson();
}

class ValueNotifierConverter<T> implements JsonConverter<ValueNotifier<T>, T> {
  const ValueNotifierConverter();

  @override
  ValueNotifier<T> fromJson(T json) => ValueNotifier<T>(json);

  @override
  T toJson(ValueNotifier<T> object) => object?.value;
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object?.value;
}

class ARKitLightTypeConverter implements JsonConverter<ARKitLightType, int> {
  const ARKitLightTypeConverter();

  @override
  ARKitLightType fromJson(int json) => ARKitLightType.values[json];

  @override
  int toJson(ARKitLightType object) => object?.index;
}

class ARKitGeometryConverter implements JsonConverter<ARKitGeometry, Map> {
  const ARKitGeometryConverter();

  @override
  ARKitGeometry fromJson(Map json) =>
      ARKitGeometry.fromJson(Map<String, dynamic>.from(json));

  @override
  Map toJson(ARKitGeometry object) => object?.toJson();
}

class ARKitPhysicsBodyTypeConverter
    implements JsonConverter<ARKitPhysicsBodyType, int> {
  const ARKitPhysicsBodyTypeConverter();

  @override
  ARKitPhysicsBodyType fromJson(int json) => ARKitPhysicsBodyType.values[json];

  @override
  int toJson(ARKitPhysicsBodyType object) => object?.index;
}

class ARKitPhysicsShapeConverter
    implements JsonConverter<ARKitPhysicsShape, Map> {
  const ARKitPhysicsShapeConverter();

  @override
  ARKitPhysicsShape fromJson(Map json) =>
      ARKitPhysicsShape.fromJson(Map<String, dynamic>.from(json));

  @override
  Map toJson(ARKitPhysicsShape object) => object?.toJson();
}

class ARKitLightingModelConverter
    implements JsonConverter<ARKitLightingModel, int> {
  const ARKitLightingModelConverter();

  @override
  ARKitLightingModel fromJson(int json) => ARKitLightingModel.values[json];

  @override
  int toJson(ARKitLightingModel object) => object?.index;
}

class ARKitFillModeConverter implements JsonConverter<ARKitFillMode, int> {
  const ARKitFillModeConverter();

  @override
  ARKitFillMode fromJson(int json) => ARKitFillMode.values[json];

  @override
  int toJson(ARKitFillMode object) => object?.index;
}

class ARKitCullModeConverter implements JsonConverter<ARKitCullMode, int> {
  const ARKitCullModeConverter();

  @override
  ARKitCullMode fromJson(int json) => ARKitCullMode.values[json];

  @override
  int toJson(ARKitCullMode object) => object?.index;
}

class ARKitTransparencyModeConverter
    implements JsonConverter<ARKitTransparencyMode, int> {
  const ARKitTransparencyModeConverter();

  @override
  ARKitTransparencyMode fromJson(int json) =>
      ARKitTransparencyMode.values[json];

  @override
  int toJson(ARKitTransparencyMode object) => object?.index;
}

class ARKitColorMaskConverter implements JsonConverter<ARKitColorMask, int> {
  const ARKitColorMaskConverter();

  @override
  ARKitColorMask fromJson(int json) {
    switch (json) {
      case 0:
        return ARKitColorMask.none;
      case 8:
        return ARKitColorMask.red;
      case 4:
        return ARKitColorMask.green;
      case 2:
        return ARKitColorMask.blue;
      case 1:
        return ARKitColorMask.alpha;
      case 15:
      default:
        return ARKitColorMask.all;
    }
  }

  @override
  int toJson(ARKitColorMask object) {
    if (object == null) {
      return null;
    }

    switch (object) {
      case ARKitColorMask.none:
        return 0;
      case ARKitColorMask.red:
        return 8;
      case ARKitColorMask.green:
        return 4;
      case ARKitColorMask.blue:
        return 2;
      case ARKitColorMask.alpha:
        return 1;
      case ARKitColorMask.all:
      default:
        return 15;
    }
  }
}

class ARKitBlendModeConverter implements JsonConverter<ARKitBlendMode, int> {
  const ARKitBlendModeConverter();

  @override
  ARKitBlendMode fromJson(int json) => ARKitBlendMode.values[json];

  @override
  int toJson(ARKitBlendMode object) => object?.index;
}

class ARKitHitTestResultTypeConverter
    implements JsonConverter<ARKitHitTestResultType, int> {
  const ARKitHitTestResultTypeConverter();

  @override
  ARKitHitTestResultType fromJson(int json) {
    switch (json) {
      case 1:
        return ARKitHitTestResultType.featurePoint;
      case 2:
        return ARKitHitTestResultType.estimatedHorizontalPlane;
      case 4:
        return ARKitHitTestResultType.estimatedVerticalPlane;
      case 8:
        return ARKitHitTestResultType.existingPlane;
      case 16:
        return ARKitHitTestResultType.existingPlaneUsingExtent;
      case 32:
        return ARKitHitTestResultType.existingPlaneUsingGeometry;
      default:
        return ARKitHitTestResultType.unknown;
    }
  }

  @override
  int toJson(ARKitHitTestResultType object) {
    switch (object) {
      case ARKitHitTestResultType.featurePoint:
        return 1;
      case ARKitHitTestResultType.estimatedHorizontalPlane:
        return 2;
      case ARKitHitTestResultType.estimatedVerticalPlane:
        return 4;
      case ARKitHitTestResultType.existingPlane:
        return 8;
      case ARKitHitTestResultType.existingPlaneUsingExtent:
        return 16;
      case ARKitHitTestResultType.existingPlaneUsingGeometry:
        return 32;
      case ARKitHitTestResultType.unknown:
      default:
        return 0;
    }
  }
}

class ARKitAnchorConverter implements JsonConverter<ARKitAnchor, Map> {
  const ARKitAnchorConverter();

  @override
  ARKitAnchor fromJson(Map json) {
    if (json == null) {
      return null;
    }
    final map = Map<String, dynamic>.from(json);
    return ARKitAnchor.fromJson(map);
  }

  @override
  Map<dynamic, dynamic> toJson(ARKitAnchor object) => object?.toJson();
}

class MatrixConverter implements JsonConverter<Matrix4, List<dynamic>> {
  const MatrixConverter();

  @override
  Matrix4 fromJson(List<dynamic> json) {
    return Matrix4.fromList(json.cast<double>());
  }

  @override
  List<dynamic> toJson(Matrix4 matrix) {
    final list = List<double>(16);
    matrix.copyIntoArray(list);
    return list;
  }
}

class MapOfMatrixConverter
    implements
        JsonConverter<Map<String, Matrix4>, Map<dynamic, List<dynamic>>> {
  const MapOfMatrixConverter();

  @override
  Map<String, Matrix4> fromJson(Map<dynamic, List<dynamic>> json) {
    const converter = MatrixConverter();
    return Map<String, List<dynamic>>.from(json)
        .map((k, v) => MapEntry(k, converter.fromJson(v)));
  }

  @override
  Map<dynamic, List<dynamic>> toJson(Map<String, Matrix4> matrix) {
    const converter = MatrixConverter();
    return matrix.map((k, v) => MapEntry(k, converter.toJson(v)));
  }
}

class Vector2Converter implements JsonConverter<Vector2, List<dynamic>> {
  const Vector2Converter();

  @override
  Vector2 fromJson(List<dynamic> json) {
    return Vector2(json[0], json[1]);
  }

  @override
  List<double> toJson(Vector2 object) {
    final list = List<double>(2);
    object.copyIntoArray(list);
    return list;
  }
}

class Vector3Converter implements JsonConverter<Vector3, List<dynamic>> {
  const Vector3Converter();

  @override
  Vector3 fromJson(List<dynamic> json) {
    return Vector3(json[0], json[1], json[2]);
  }

  @override
  List<dynamic> toJson(Vector3 object) {
    final list = List<double>(3);
    object.copyIntoArray(list);
    return list;
  }
}

class Vector4Converter implements JsonConverter<Vector4, List<dynamic>> {
  const Vector4Converter();

  @override
  Vector4 fromJson(List<dynamic> json) {
    return Vector4(json[0], json[1], json[2], json[3]);
  }

  @override
  List<dynamic> toJson(Vector4 object) {
    final list = List<double>(4);
    object.copyIntoArray(list);
    return list;
  }
}

class Vector3ValueNotifierConverter
    implements JsonConverter<ValueNotifier<Vector3>, List<dynamic>> {
  const Vector3ValueNotifierConverter();

  @override
  ValueNotifier<Vector3> fromJson(List<dynamic> json) {
    return ValueNotifier(Vector3.fromFloat64List(json.cast<double>()));
  }

  @override
  List<dynamic> toJson(ValueNotifier<Vector3> object) {
    if (object.value == null) {
      return null;
    }
    final list = List<double>(3);
    object?.value?.copyIntoArray(list);
    return list;
  }
}

class Vector4ValueNotifierConverter
    implements JsonConverter<ValueNotifier<Vector4>, List<dynamic>> {
  const Vector4ValueNotifierConverter();

  @override
  ValueNotifier<Vector4> fromJson(List<dynamic> json) {
    return ValueNotifier(Vector4.fromFloat64List(json.cast<double>()));
  }

  @override
  List<dynamic> toJson(ValueNotifier<Vector4> object) {
    if (object.value == null) {
      return null;
    }
    final list = List<double>(4);
    object?.value?.copyIntoArray(list);
    return list;
  }
}
