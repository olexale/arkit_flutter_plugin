/// Possible values that describe position tracking quality
/// copied over from ARTrackingState: https://developer.apple.com/documentation/arkit/artrackingstate
enum ARTrackingState {
  notAvailable, // Camera position tracking is not available.
  limited, // Tracking is available, but the quality of results is questionable.
  normal, // Camera position tracking is providing optimal results.
}

/// if ARTrackingState is limited, it may come with a reason
/// https://developer.apple.com/documentation/arkit/arcamera/trackingstate/reason
enum ARTrackingStateReason {
  initializing, // The AR session has not yet gathered enough camera or motion data to provide tracking information.
  relocalizing, // The AR session is attempting to resume after an interruption.
  excessiveMotion, // The device is moving too fast for accurate image-based position tracking.
  insufficientFeatures // The scene visible to the camera does not contain enough distinguishable features for image-based position tracking.
}
