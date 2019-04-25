/// Indicating the type of planes to detect.
enum ARPlaneDetection {
  /// No plane detection is run
  none,

  /// Plane detection determines horizontal planes in the scene.
  horizontal,

  /// Plane detection determines vertical planes in the scene. (iOS >= 11.3)
  vertical,

  /// Plane detection determines both horizontal and vertical planes in the scene. (iOS >= 11.3)
  horizontalAndVertical,
}
