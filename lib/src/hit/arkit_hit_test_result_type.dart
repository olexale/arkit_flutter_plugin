/// Option set of hit-test result types.
enum ARKitHitTestResultType {
  /// If you have this value you might face a bug in the plugin, sorry. Please create an issue on GitHub.
  unknown,

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
