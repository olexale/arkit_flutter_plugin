import ARKit
import Foundation

@available(iOS 11.3, *)
func parseReferenceImagesSet(_ images: [[String: Any]]) -> Set<ARReferenceImage> {
  let conv = images.compactMap { parseReferenceImage($0) }
  return Set(conv)
}

@available(iOS 11.3, *)
func parseReferenceImage(_ dict: [String: Any]) -> ARReferenceImage? {
  if let physicalWidth = dict["physicalWidth"] as? Double,
     let name = dict["name"] as? String,
     let image = getImageByName(name),
     let cgImage = image.cgImage
  {
    let referenceImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: CGFloat(physicalWidth))
    referenceImage.name = name
    return referenceImage
  }
  return nil
}
