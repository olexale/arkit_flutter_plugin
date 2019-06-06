/// Enum constants for indicating the world alignment.
enum ARWorldAlignment {
  /// Aligns the world with gravity that is defined by vector (0, -1, 0).
  gravity,

  /// Aligns the world with gravity that is defined by the vector (0, -1, 0)
  /// and heading (w.r.t. True North) that is given by the vector (0, 0, -1).
  gravityAndHeading,

  /// Aligns the world with the camera’s orientation.
  camera,
}
