/// Possible values that describe position tracking quality
/// copied over from ARTrackingState: https://developer.apple.com/documentation/arkit/artrackingstate
enum ARTrackingState { notAvailable, limited, normal }

/// if ARTrackingState is limited, it may come with a reason
/// https://developer.apple.com/documentation/arkit/arcamera/trackingstate/reason
enum ARTrackingStateReason {
  initializing,
  relocalizing,
  excessiveMotion,
  insufficientFeatures
}

/// Converts AR Tracking State from string to enum
/// return null if given an unexpected value
ARTrackingState ARTrackingStateFromString(String trackingState) {
  switch (trackingState) {
    case 'notAvailable':
      return ARTrackingState.notAvailable;
    case 'limited':
      return ARTrackingState.limited;
    case 'normal':
      return ARTrackingState.normal;
    default:
      print("Received unexpected camera tracking state.");
  }
  return null;
}

/// Converts AR Tracking State Reason from string to enum
/// return null if given an unexpected value
ARTrackingStateReason ARTrackingStateReasonFromString(String reason) {
  switch (reason) {
    case 'excessiveMotion':
      return ARTrackingStateReason.excessiveMotion;
    case 'insufficientFeatures':
      return ARTrackingStateReason.insufficientFeatures;
    case 'initializing':
      return ARTrackingStateReason.initializing;
    case 'relocalizing':
      return ARTrackingStateReason.relocalizing;
    default:
      print('No reason given for limited camera tracking quality.');
  }
  return null;
}
