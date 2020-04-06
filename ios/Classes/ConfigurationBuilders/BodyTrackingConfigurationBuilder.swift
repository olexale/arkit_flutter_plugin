import Foundation
import ARKit

@available(iOS 13.0, *)
func createBodyTrackingConfiguration(_ arguments: Dictionary<String, Any>) -> ARBodyTrackingConfiguration? {
    if(ARBodyTrackingConfiguration.isSupported) {
        return ARBodyTrackingConfiguration()
    }
    return nil
}
