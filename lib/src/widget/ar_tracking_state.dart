/// A value describing the camera's tracking state.
enum ARTrackingState {
  /// Camera position tracking is not available.
  notAvailable,

  /// Tracking is available, but the quality of results is questionable.
  limited,

  /// Camera position tracking is providing optimal results.
  normal,
}

/// The reason why ARTrackingState is limited
enum ARTrackingStateReason {
  /// This should not happen. Please create an issue for the plugin.
  unknown,

  /// Tracking is limited due to initialization in progress.
  initializing,

  /// Tracking is limited due to a relocalization in progress.
  relocalizing,

  /// Tracking is limited due to a excessive motion of the camera.
  excessiveMotion,

  /// Tracking is limited due to a lack of features visible to the camera.
  insufficientFeatures,
}
