/// Blend modes that ARKitMaterial uses to compose with the framebuffer to produce blended colors.
enum ARKitBlendMode {
  /// Blends the source and destination colors by adding the source multiplied by source alpha and the destination multiplied by one minus source alpha.
  alpha,

  /// Blends the source and destination colors by adding them up.
  add,

  /// Blends the source and destination colors by subtracting the source from the destination.
  subtract,

  /// Blends the source and destination colors by multiplying them.
  multiply,

  /// Blends the source and destination colors by multiplying one minus the source with the destination and adding the source.
  screen,

  /// Replaces the destination with the source (ignores alpha).
  replace,

  /// Max the destination with the source (ignores alpha).
  max,
}
