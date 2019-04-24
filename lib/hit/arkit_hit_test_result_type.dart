/// Option set of hit-test result types.
class ARKitHitTestResultType {
  const ARKitHitTestResultType(
    this.featurePoint,
    this.estimatedHorizontalPlane,
    this.estimatedVerticalPlane,
    this.existingPlane,
    this.existingPlaneUsingExtent,
    this.existingPlaneUsingGeometry,
  );

  /// Result type from intersecting the nearest feature point.
  final bool featurePoint;

  /// Result type from intersecting a horizontal plane estimate, determined for the current frame.
  final bool estimatedHorizontalPlane;

  /// Result type from intersecting a vertical plane estimate, determined for the current frame.
  final bool estimatedVerticalPlane;

  /// Result type from intersecting with an existing plane anchor.
  final bool existingPlane;

  /// Result type from intersecting with an existing plane anchor, taking into account the plane’s extent.
  final bool existingPlaneUsingExtent;

  /// Result type from intersecting with an existing plane anchor, taking into account the plane’s geometry.
  final bool existingPlaneUsingGeometry;

  static ARKitHitTestResultType fromNumber(int number) =>
      ARKitHitTestResultType(
        number == 1,
        number == 2,
        number == 4,
        number == 8,
        number == 16,
        number == 32,
      );
}
