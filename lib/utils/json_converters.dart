import 'dart:ui';

import 'package:arkit_plugin/geometries/material/arkit_blend_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_color_mask.dart';
import 'package:arkit_plugin/geometries/material/arkit_cull_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_fill_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_lighting_model.dart';
import 'package:arkit_plugin/geometries/material/arkit_material_property.dart';
import 'package:arkit_plugin/geometries/material/arkit_transparency_mode.dart';
import 'package:arkit_plugin/light/arkit_light_type.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

class DoubleValueNotifierConverter extends ValueNotifierConverter<double> {
  const DoubleValueNotifierConverter() : super();
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
        break;
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

class ARKitMaterialPropertyConverter
    implements JsonConverter<ARKitMaterialProperty, Map<String, dynamic>> {
  const ARKitMaterialPropertyConverter();

  @override
  ARKitMaterialProperty fromJson(Map<String, dynamic> json) =>
      ARKitMaterialProperty.fromJson(json);

  @override
  Map<String, dynamic> toJson(ARKitMaterialProperty object) => object?.toJson();
}
