/// The mode of environment texturing to run.
enum ARWorldTrackingConfigurationEnvironmentTexturing {
  /// No texture information is gathered.
  none,

  /// Texture information is gathered for the environment.
  /// Environment textures will be generated for AREnvironmentProbes added to the session.
  manual,

  /// Texture information is gathered for the environment and probes automatically placed in the scene.
  automatic,
}
