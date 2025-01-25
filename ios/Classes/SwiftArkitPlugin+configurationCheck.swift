import ARKit

func checkConfiguration(_ arguments: Any?) -> Bool {
    guard let arguments = arguments as? [String: Any],
          let configurationType = arguments["configuration"] as? Int
    else {
        return false
    }

    switch configurationType {
    case 0:
        return ARWorldTrackingConfiguration.isSupported
    case 1:
        #if !DISABLE_TRUEDEPTH_API
            return ARFaceTrackingConfiguration.isSupported
        #else
            return false
        #endif
    case 2:
        return ARImageTrackingConfiguration.isSupported
    case 3:
        if #available(iOS 13.0, *) {
            return ARBodyTrackingConfiguration.isSupported
        } else {
            return false
        }
    case 4:
        if #available(iOS 14.0, *) {
            return ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth)
        } else {
            return false
        }
    default:
        return false
    }
}
