import ARKit

func createSphere(_ arguments: Dictionary<String, Any>) -> SCNSphere {
    let radius = arguments["radius"] as! Double
    return SCNSphere(radius: CGFloat(radius))
}

func createPlane(_ arguments: Dictionary<String, Any>) -> SCNPlane {
    let width = arguments["width"] as! Double
    let height = arguments["height"] as! Double
    let widthSegmentCount = arguments["widthSegmentCount"] as! Int
    let heightSegmentCount = arguments["heightSegmentCount"] as! Int
    
    let plane = SCNPlane(width: CGFloat(width), height: CGFloat(height))
    plane.widthSegmentCount = widthSegmentCount
    plane.heightSegmentCount = heightSegmentCount
    return plane
}

func createText(_ arguments: Dictionary<String, Any>) -> SCNText {
    let extrusionDepth = arguments["extrusionDepth"] as! Double
    return SCNText(string: arguments["text"], extrusionDepth: CGFloat(extrusionDepth))
}

func createBox(_ arguments: Dictionary<String, Any>) -> SCNBox {
    let width = arguments["width"] as! Double
    let height = arguments["height"] as! Double
    let length = arguments["length"] as! Double
    let chamferRadius = arguments["chamferRadius"] as! Double
    
    return SCNBox(width: CGFloat(width), height: CGFloat(height), length: CGFloat(length), chamferRadius: CGFloat(chamferRadius))
}

func createLine(_ arguments: Dictionary<String, Any>) -> SCNGeometry {
    let fromVector = deserizlieVector3(arguments["fromVector"] as! Array<Double>)
    let toVector = deserizlieVector3(arguments["toVector"] as! Array<Double>)
    let source = SCNGeometrySource(vertices: [fromVector, toVector])
    
    let indices: [UInt8] = [0,1]
    let element = SCNGeometryElement(indices: indices, primitiveType: .line)
    
    return SCNGeometry(sources: [source], elements: [element])
}

func createCylinder(_ arguments: Dictionary<String, Any>) -> SCNCylinder {
    let radius = arguments["radius"] as! Double
    let height = arguments["height"] as! Double
    return SCNCylinder(radius: CGFloat(radius), height: CGFloat(height))
}

func createCone(_ arguments: Dictionary<String, Any>) -> SCNCone {
    let topRadius = arguments["topRadius"] as! Double
    let bottomRadius = arguments["bottomRadius"] as! Double
    let height = arguments["height"] as! Double
    return SCNCone(topRadius: CGFloat(topRadius), bottomRadius: CGFloat(bottomRadius), height: CGFloat(height))
}

func createPyramid(_ arguments: Dictionary<String, Any>) -> SCNPyramid {
    let width = arguments["width"] as! Double
    let height = arguments["height"] as! Double
    let length = arguments["length"] as! Double
    return SCNPyramid(width: CGFloat(width), height: CGFloat(height), length: CGFloat(length))
}

func createTube(_ arguments: Dictionary<String, Any>) -> SCNTube {
    let innerRadius = arguments["innerRadius"] as! Double
    let outerRadius = arguments["outerRadius"] as! Double
    let height = arguments["height"] as! Double
    return SCNTube(innerRadius: CGFloat(innerRadius), outerRadius: CGFloat(outerRadius), height: CGFloat(height))
}

func createTorus(_ arguments: Dictionary<String, Any>) -> SCNTorus {
    let ringRadius = arguments["ringRadius"] as! Double
    let pipeRadius = arguments["pipeRadius"] as! Double
    return SCNTorus(ringRadius: CGFloat(ringRadius), pipeRadius: CGFloat(pipeRadius))
}

func createCapsule(_ arguments: Dictionary<String, Any>) -> SCNCapsule {
    let capRadius = arguments["capRadius"] as! Double
    let height = arguments["height"] as! Double
    return SCNCapsule(capRadius: CGFloat(capRadius), height: CGFloat(height))
}

#if !DISABLE_TRUEDEPTH_API
func createFace(_ device: MTLDevice?) -> ARSCNFaceGeometry {
    return ARSCNFaceGeometry(device: device!)!
}
#endif
