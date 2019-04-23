/// A light estimate representing the light in the scene.
class ARKitLightEstimate {
  ARKitLightEstimate._(this.ambientIntensity, this.ambientColorTemperature);

  static ARKitLightEstimate fromMap(Map<String, double> map) =>
      ARKitLightEstimate._(
        map['ambientIntensity'],
        map['ambientColorTemperature'],
      );

  /// Ambient intensity of the lighting.
  /// In a well lit environment, this value is close to 1000.
  /// It typically ranges from 0 (very dark) to around 2000 (very bright).
  final double ambientIntensity;

  /// The ambient color temperature of the lighting.
  /// This specifies the ambient color temperature of the lighting in Kelvin (6500 corresponds to pure white).
  final double ambientColorTemperature;
}
