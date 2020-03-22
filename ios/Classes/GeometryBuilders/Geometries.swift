import ARKit

func createSphere(_ arguments: Dictionary<String, Any>, _ device: MTLDevice?) -> SCNSphere {
    let radius = arguments["radius"] as! Double
    return SCNSphere(radius: CGFloat(radius))
}

