import Foundation
import ARKit

func serializeAnchor(_ anchor: ARAnchor) -> Dictionary<String, Any> {
    var params = [
        "identifier": anchor.identifier.uuidString,
        "transform": serializeMatrix(anchor.transform)
        ] as [String : Any]
    
    if let planeAnchor = anchor as? ARPlaneAnchor {
        params = serializePlaneAnchor(planeAnchor, params)
    }
    
    if #available(iOS 11.3, *) {
        if let imageAnchor = anchor as? ARImageAnchor {
            params = serializeImageAnchor(imageAnchor, params)
        }
    }
    
    #if !DISABLE_TRUEDEPTH_API
    if #available(iOS 12.0, *) {
        if let faceAnchor = anchor as? ARFaceAnchor {
            params = serializeFaceAnchor(faceAnchor, params)
        }
    }
    #endif
    
    if #available(iOS 13.0, *) {
        if let bodyAnchor = anchor as? ARBodyAnchor {
            params = serializeBodyAnchor(bodyAnchor, params)
        }
    }
    
    return params
}

fileprivate func serializePlaneAnchor(_ anchor: ARPlaneAnchor, _ params:[String : Any]) -> [String : Any]{
    var params = params
    params["anchorType"] = "planeAnchor"
    params["center"] = serializeArray(anchor.center)
    params["extent"] = serializeArray(anchor.extent)
    return params
}

@available(iOS 11.3, *)
fileprivate func serializeImageAnchor(_ anchor: ARImageAnchor, _ params:[String : Any]) -> [String : Any]{
    var params = params
    params["anchorType"] = "imageAnchor"
    
    if let referenceImageName = anchor.referenceImage.name {
        params["referenceImageName"] = referenceImageName
    }
    params["isTracked"] = anchor.isTracked
    params["referenceImagePhysicalSize"] = [anchor.referenceImage.physicalSize.width, anchor.referenceImage.physicalSize.height]
    return params
}

#if !DISABLE_TRUEDEPTH_API
@available(iOS 12.0, *)
fileprivate func serializeFaceAnchor(_ anchor: ARFaceAnchor, _ params:[String : Any]) -> [String : Any]{
    var params = params
    params["anchorType"] = "faceAnchor"
    params["isTracked"] = anchor.isTracked
    params["leftEyeTransform"] = serializeMatrix(anchor.leftEyeTransform)
    params["rightEyeTransform"] = serializeMatrix(anchor.rightEyeTransform)
    params["blendShapes"] = anchor.blendShapes
    return params
}
#endif

@available(iOS 13.0, *)
fileprivate func serializeBodyAnchor(_ anchor: ARBodyAnchor, _ params:[String : Any]) -> [String : Any]{
    var params = params
    params["anchorType"] = "bodyAnchor"
    params["isTracked"] = anchor.isTracked
    
    let modelTransforms = [
        "root": serializeMatrix(anchor.skeleton.modelTransform(for: .root) ?? simd_float4x4.init()),
        "head": serializeMatrix(anchor.skeleton.modelTransform(for: .head) ?? simd_float4x4.init()),
        "leftHand": serializeMatrix(anchor.skeleton.modelTransform(for: .leftHand) ?? simd_float4x4.init()),
        "rightHand": serializeMatrix(anchor.skeleton.modelTransform(for: .rightHand) ?? simd_float4x4.init()),
        "leftFoot": serializeMatrix(anchor.skeleton.modelTransform(for: .leftFoot) ?? simd_float4x4.init()),
        "rightFoot": serializeMatrix(anchor.skeleton.modelTransform(for: .rightFoot) ?? simd_float4x4.init()),
        "leftShoulder": serializeMatrix(anchor.skeleton.modelTransform(for: .leftShoulder) ?? simd_float4x4.init()),
        "rightShoulder": serializeMatrix(anchor.skeleton.modelTransform(for: .rightShoulder) ?? simd_float4x4.init())
    ]
    let localTransforms = [
        "root": serializeMatrix(anchor.skeleton.localTransform(for: .root) ?? simd_float4x4.init()),
        "head": serializeMatrix(anchor.skeleton.localTransform(for: .head) ?? simd_float4x4.init()),
        "leftHand": serializeMatrix(anchor.skeleton.localTransform(for: .leftHand) ?? simd_float4x4.init()),
        "rightHand": serializeMatrix(anchor.skeleton.localTransform(for: .rightHand) ?? simd_float4x4.init()),
        "leftFoot": serializeMatrix(anchor.skeleton.localTransform(for: .leftFoot) ?? simd_float4x4.init()),
        "rightFoot": serializeMatrix(anchor.skeleton.localTransform(for: .rightFoot) ?? simd_float4x4.init()),
        "leftShoulder": serializeMatrix(anchor.skeleton.localTransform(for: .leftShoulder) ?? simd_float4x4.init()),
        "rightShoulder": serializeMatrix(anchor.skeleton.localTransform(for: .rightShoulder) ?? simd_float4x4.init())
    ]
    let skeleton = [
        "modelTransforms": modelTransforms,
        "localTransforms": localTransforms
    ]
    params["skeleton"] = skeleton
    return params
}
