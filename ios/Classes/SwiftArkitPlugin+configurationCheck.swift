import ARKit

func checkConfiguration(_ arguments: Any?) -> Bool {
    guard let arguments = arguments as? Dictionary<String, Any>,
        let configurationType = arguments["configuration"] as? Int else {
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
        if #available(iOS 12.0, *) {
            return ARImageTrackingConfiguration.isSupported
        } else {
            return false
        }
    case 3:
        if #available(iOS 13.0, *) {
            return ARBodyTrackingConfiguration.isSupported
        } else {
            return false
        }
    default:
        return false
    }
}
