import Foundation
import ARKit

@available(iOS 12.0, *)
func createImageTrackingConfiguration(_ arguments: Dictionary<String, Any>) -> ARImageTrackingConfiguration? {
    if(ARImageTrackingConfiguration.isSupported) {
        let imageTrackingConfiguration = ARImageTrackingConfiguration()
        
        if let trackingImagesGroupName = arguments["trackingImagesGroupName"] as? String,
            let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: trackingImagesGroupName, bundle: nil) {
            imageTrackingConfiguration.trackingImages = referenceImages
        }
        if let trackingImages = arguments["trackingImages"] as? Array<Dictionary<String, Any>> {
            imageTrackingConfiguration.trackingImages = parseReferenceImagesSet(trackingImages)
        }
        return imageTrackingConfiguration
    }
    return nil
}
