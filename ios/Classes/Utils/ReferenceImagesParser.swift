import Foundation
import ARKit

@available(iOS 11.3, *)
func parseReferenceImagesSet(_ images: Array<Dictionary<String, Any>>) -> Set<ARReferenceImage> {
    let conv = images.compactMap { parseReferenceImage($0) }
    return Set(conv)
}

@available(iOS 11.3, *)
func parseReferenceImage(_ dict: Dictionary<String, Any>) -> ARReferenceImage? {
    if let physicalWidth = dict["physicalWidth"] as? Double,
        let name = dict["name"] as? String,
        let image = getImageByName(name),
        let cgImage = image.cgImage {
        
        let referenceImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: CGFloat(physicalWidth))
        return referenceImage
    }
    return nil
}
