import ARKit
import Foundation

#if !DISABLE_TRUEDEPTH_API
func createFaceTrackingConfiguration(_: [String: Any]) -> ARFaceTrackingConfiguration? {
  if ARFaceTrackingConfiguration.isSupported {
    return ARFaceTrackingConfiguration()
  }
  return nil
}
#endif
