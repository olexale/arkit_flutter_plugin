import ARKit
import Foundation

@available(iOS 12.0, *)
func createImageTrackingConfiguration(_ arguments: [String: Any]) -> ARImageTrackingConfiguration? {
  if ARImageTrackingConfiguration.isSupported {
    let imageTrackingConfiguration = ARImageTrackingConfiguration()
    
    if let trackingImagesGroupName = arguments["trackingImagesGroupName"] as? String,
       let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: trackingImagesGroupName, bundle: nil)
    {
      imageTrackingConfiguration.trackingImages = referenceImages
    }
    if let trackingImages = arguments["trackingImages"] as? [[String: Any]] {
      imageTrackingConfiguration.trackingImages = parseReferenceImagesSet(trackingImages)
    }
    if let maximumNumberOfTrackedImages = arguments["maximumNumberOfTrackedImages"] as? Int {
      imageTrackingConfiguration.maximumNumberOfTrackedImages = maximumNumberOfTrackedImages
    }
    return imageTrackingConfiguration
  }
  return nil
}
