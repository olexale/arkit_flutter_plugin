/// Option set of hit-test result types.
enum ARKitHitTestResultType {
  /// Result type from intersecting the nearest feature point.
  featurePoint,

  /// Result type from intersecting a horizontal plane estimate, determined for the current frame.
  estimatedHorizontalPlane,

  /// Result type from intersecting a vertical plane estimate, determined for the current frame.
  estimatedVerticalPlane,

  /// Result type from intersecting with an existing plane anchor.
  existingPlane,

  /// Result type from intersecting with an existing plane anchor, taking into account the plane’s extent.
  existingPlaneUsingExtent,

  /// Result type from intersecting with an existing plane anchor, taking into account the plane’s geometry.
  existingPlaneUsingGeometry,
}

ARKitHitTestResultType aRKitHitTestResultTypeFromInt(int number) {
  switch (number) {
    case 1:
      return ARKitHitTestResultType.featurePoint;
    case 2:
      return ARKitHitTestResultType.estimatedHorizontalPlane;
    case 4:
      return ARKitHitTestResultType.estimatedVerticalPlane;
    case 8:
      return ARKitHitTestResultType.existingPlane;
    case 16:
      return ARKitHitTestResultType.existingPlaneUsingExtent;
    case 32:
      return ARKitHitTestResultType.existingPlaneUsingGeometry;
    default:
      return null;
  }
}
