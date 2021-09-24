/// A value describing the context required for successful coaching
enum CoachingOverlayGoal {
  /// Session requires normal tracking
  tracking,

  /// Session requires a horizontal plane
  horizontalPlane,

  /// Session requires a vertical plane
  verticalPlane,

  /// Session requires one plane of any type
  anyPlane,
}
