enum ARKitTransparencyMode {
  /// Takes the transparency information from the alpha channel. The value 1.0 is opaque.
  aOne,

  /// Ignores the alpha channel and takes the transparency information from the luminance of the red, green, and blue channels.
  /// The value 0.0 is opaque.
  rgbZero,

  /// Ensures that one layer of transparency is draw correctly.
  singleLayer,

  /// Ensures that two layers of transparency are ordered and drawn correctly.
  /// This should be used for transparent convex objects like cubes and spheres, when you want to see both front and back faces.
  dualLayer,
}
