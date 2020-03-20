import 'package:arkit_plugin/light/arkit_light_type.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_light.g.dart';

/// ARKitLight represents a light that can be attached to a ARKitNode.
@JsonSerializable()
class ARKitLight {
  ARKitLight({
    this.type = ARKitLightType.omni,
    this.color = Colors.white,
    this.temperature = 6500,
    double intensity,
    this.spotInnerAngle = 0,
    this.spotOuterAngle = 45,
  }) : intensity = ValueNotifier(intensity ?? 1000);

  /// Light type.
  /// Defaults to ARKitLightType.omni.
  @ARKitLightTypeConverter()
  final ARKitLightType type;

  /// Specifies the receiver's color.
  /// Defaults to white.
  /// The renderer multiplies the light's color is by the color derived from the light's temperature.
  @ColorConverter()
  final Color color;

  /// This specifies the temperature of the light in Kelvin.
  /// The renderer multiplies the light's color by the color derived from the light's temperature.
  /// Defaults to 6500 (pure white).
  final double temperature;

  /// This intensity is used to modulate the light color.
  /// When used with a physically-based material, this corresponds to the luminous flux of the light, expressed in lumens (lm).
  /// Defaults to 1000.
  @DoubleValueNotifierConverter()
  final ValueNotifier<double> intensity;

  /// The angle in degrees between the spot direction and the lit element below which the lighting is at full strength.
  /// Defaults to 0.
  final double spotInnerAngle;

  /// The angle in degrees between the spot direction and the lit element after which the lighting is at zero strength.
  /// Defaults to 45 degrees.
  final double spotOuterAngle;

  static ARKitLight fromJson(Map<String, dynamic> json) =>
      _$ARKitLightFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitLightToJson(this);
}
