import ARKit

func createNode(_ geometry: SCNGeometry?, fromDict dict: Dictionary<String, Any>, forDevice device: MTLDevice?) -> SCNNode {
    let dartType = dict["dartType"] as! String
    
    let node = dartType == "ARKitReferenceNode"
        ? createReferenceNode(dict)
        : SCNNode(geometry: geometry)
    
    if let position = dict["position"] as? Array<Double> {
        node.position = deserizlieVector3(position)
    }
    
    if let scale = dict["scale"] as? Array<Double> {
        node.scale = deserizlieVector3(scale)
    }
    
    if let rotation = dict["rotation"] as? Array<Double> {
        node.rotation = deserizlieVector4(rotation)
    }
    
    if let name = dict["name"] as? String {
        node.name = name
    }
    
    if let physicsBody = dict["physicsBody"] as? Dictionary<String, Any> {
        node.physicsBody = createPhysicsBody(physicsBody, forDevice: device)
    }
    
    if let light = dict["light"] as? Dictionary<String, Any> {
        node.light = createLight(light)
    }
    
    if let renderingOrder = dict["renderingOrder"] as? Int {
        node.renderingOrder = renderingOrder
    }
    
    return node
}

fileprivate func createReferenceNode(_ dict: Dictionary<String, Any>) -> SCNReferenceNode {
    let url = dict["url"] as! String
    let referenceUrl = Bundle.main.url(forResource: url, withExtension: nil)
    let node = SCNReferenceNode(url: referenceUrl!)
    node?.load()
    return node!
}

fileprivate func createPhysicsBody(_ dict: Dictionary<String, Any>, forDevice device: MTLDevice?) -> SCNPhysicsBody {
    var shape: SCNPhysicsShape?
    if let shapeDict = dict["shape"] as? Dictionary<String, Any>,
        let shapeGeometry = shapeDict["geometry"] as? Dictionary<String, Any> {
        let geometry = createGeometry(shapeGeometry, withDevice: device)
        shape = SCNPhysicsShape(geometry: geometry!, options: nil)
    }
    let type = dict["type"] as! Int
    let bodyType = SCNPhysicsBodyType(rawValue: type)
    let physicsBody = SCNPhysicsBody(type: bodyType!, shape: shape)
    if let categoryBitMack = dict["categoryBitMask"] as? Int {
        physicsBody.categoryBitMask = categoryBitMack
    }
    return physicsBody
}

fileprivate func createLight(_ dict: Dictionary<String, Any>) -> SCNLight {
    let light = SCNLight()
    if let type = dict["type"] as? Int {
        switch type {
        case 0:
            light.type = .ambient
            break
        case 1:
            light.type = .omni
            break
        case 2:
            light.type = .directional
            break
        case 3:
            light.type = .spot
            break
        case 4:
            light.type = .IES
            break
        case 5:
            light.type = .probe
            break
        case 6:
            if #available(iOS 13.0, *) {
                light.type = .area
            } else {
                // error
                light.type = .omni
            }
            break
        default:
            light.type = .omni
            break
        }
    } else {
        light.type = .omni
    }
    if let temperature = dict["temperature"] as? Double {
        light.temperature = CGFloat(temperature)
    }
    if let intensity = dict["intensity"] as? Double {
        light.intensity = CGFloat(intensity)
    }
    if let spotInnerAngle = dict["spotInnerAngle"] as? Double {
        light.spotInnerAngle = CGFloat(spotInnerAngle)
    }
    if let spotOuterAngle = dict["spotOuterAngle"] as? Double {
        light.spotOuterAngle = CGFloat(spotOuterAngle)
    }
    if let color = dict["color"] as? Int {
        light.color = UIColor(rgb: UInt(color))
    }
    return light
}
