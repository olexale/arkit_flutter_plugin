import ARKit
import Foundation

@available(iOS 14.0, *)
func createDepthTrackingConfiguration(_ arguments: [String: Any]) -> ARWorldTrackingConfiguration? {
    if ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth) {
        let depthTrackingConfiguration = ARWorldTrackingConfiguration()
        depthTrackingConfiguration.frameSemantics = [.sceneDepth]

        if let environmentTexturing = arguments["environmentTexturing"] as? Int {
            if environmentTexturing == 0 {
                depthTrackingConfiguration.environmentTexturing = .none
            } else if environmentTexturing == 1 {
                depthTrackingConfiguration.environmentTexturing = .manual
            } else if environmentTexturing == 2 {
                depthTrackingConfiguration.environmentTexturing = .automatic
            }
        }
        if let planeDetection = arguments["planeDetection"] as? Int {
            if planeDetection == 1 {
                depthTrackingConfiguration.planeDetection = .horizontal
            }
            if planeDetection == 2 {
                depthTrackingConfiguration.planeDetection = .vertical
            }
            if planeDetection == 3 {
                depthTrackingConfiguration.planeDetection = [.horizontal, .vertical]
            }
        }
        if let detectionImagesGroupName = arguments["detectionImagesGroupName"] as? String {
            depthTrackingConfiguration.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: detectionImagesGroupName, bundle: nil)
        }
        if let detectionImages = arguments["detectionImages"] as? [[String: Any]] {
            depthTrackingConfiguration.detectionImages = parseReferenceImagesSet(detectionImages)
        }
        if let maximumNumberOfTrackedImages = arguments["maximumNumberOfTrackedImages"] as? Int {
            depthTrackingConfiguration.maximumNumberOfTrackedImages = maximumNumberOfTrackedImages
        }

        return depthTrackingConfiguration
    }
    return nil
}
