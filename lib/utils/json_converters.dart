import 'dart:ui';

import 'package:arkit_plugin/light/arkit_light_type.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

class ValueNotifierConverter
    implements JsonConverter<ValueNotifier<double>, double> {
  const ValueNotifierConverter();

  @override
  ValueNotifier<double> fromJson(double json) => ValueNotifier<double>(json);

  @override
  double toJson(ValueNotifier<double> object) => object?.value;
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.value;
}

class ARKitLightTypeConverter implements JsonConverter<ARKitLightType, int> {
  const ARKitLightTypeConverter();

  @override
  ARKitLightType fromJson(int json) => ARKitLightType.values[json];

  @override
  int toJson(ARKitLightType object) => object.index;
}
