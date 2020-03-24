import 'package:json_annotation/json_annotation.dart';

part 'arkit_light_estimate.g.dart';

/// A light estimate representing the light in the scene.
@JsonSerializable()
class ARKitLightEstimate {
  const ARKitLightEstimate({
    this.ambientIntensity,
    this.ambientColorTemperature,
  });

  /// Ambient intensity of the lighting.
  /// In a well lit environment, this value is close to 1000.
  /// It typically ranges from 0 (very dark) to around 2000 (very bright).
  final double ambientIntensity;

  /// The ambient color temperature of the lighting.
  /// This specifies the ambient color temperature of the lighting in Kelvin (6500 corresponds to pure white).
  final double ambientColorTemperature;

  static ARKitLightEstimate fromJson(Map<String, double> map) =>
      _$ARKitLightEstimateFromJson(map);

  Map<String, dynamic> toJson() => _$ARKitLightEstimateToJson(this);
}
