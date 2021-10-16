/// Determines the object type to describe and configure the Augmented Reality techniques to be used in an ARSession.
enum ARKitConfiguration {
  /// A configuration for running world tracking.
  /// World tracking provides 6 degrees of freedom tracking of the device.
  /// By finding feature points in the scene, world tracking enables performing hit-tests against the frame.
  /// Tracking can no longer be resumed once the session is paused.
  worldTracking,

  /// A configuration for running face tracking.
  /// Face tracking uses the front facing camera to track the face in 3D providing details on the topology and expression of the face.
  /// A detected face will be added to the session as an ARFaceAnchor object which contains information about head pose, mesh, eye pose, and blend shape
  /// coefficients. If light estimation is enabled the detected face will be treated as a light probe and used to estimate the direction of incoming light.
  faceTracking,

  /// A configuration for running image tracking.
  /// Image tracking provides 6 degrees of freedom tracking of known images. Four images may be tracked simultaneously.
  imageTracking,

  /// A configuration for running body tracking.
  /// Body tracking provides 6 degrees of freedom tracking of a detected body in the scene.
  bodyTracking,
}
