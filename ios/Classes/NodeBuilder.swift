import ARKit
import GLTFSceneKit
import os

func createNode(_ geometry: SCNGeometry?, fromDict dict: Dictionary<String, Any>, forDevice device: MTLDevice?) -> SCNNode {
    let dartType = dict["dartType"] as! String
    var node: SCNNode
    
    switch dartType {
    case "ARKitReferenceNode":
        node = createReferenceNode(dict)
    case "ARKitGltfNode":
        node = createGltfNode(dict)
    default:
        node = SCNNode(geometry: geometry)
    }
    
    updateNode(node, fromDict: dict, forDevice: device)
    
    return node
}

func updateNode(_ node: SCNNode, fromDict dict: Dictionary<String, Any>, forDevice device: MTLDevice?) {
    if let transform = dict["transform"] as? Array<NSNumber> {
        node.transform = deserializeMatrix4(transform)
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

    if let isHidden = dict["isHidden"] as? Bool {
        node.isHidden = isHidden
    }
}

fileprivate func createGltfNode(_ dict: Dictionary<String, Any>) -> SCNNode {
    let url = dict["url"] as! String
    let urlLowercased = url.lowercased()
    let node: SCNNode = SCNNode()
    if urlLowercased.hasSuffix(".gltf") || urlLowercased.hasSuffix(".glb") {
        var scene: SCNScene
        let assetType = AssetType.from(index: dict["assetType"] as! Int)
        let url = dict["url"] as! String
        var modelPath : String
        var sceneSource : GLTFSceneSource
        
        do{
            if assetType == .flutterAsset {
                modelPath = FlutterDartProject.lookupKey(forAsset: url)
                sceneSource = try GLTFSceneSource(named: modelPath)
            }else { //assetType == .documents
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                modelPath = documentsDirectory.appendingPathComponent(url).path
                sceneSource = try GLTFSceneSource(path: modelPath)
            }
            scene = try sceneSource.scene()
            
            for child in scene.rootNode.childNodes {
                node.addChildNode(child.flattenedClone())
            }
            
            if let name = dict["name"] as? String {
                node.name = name
            }
            if let transform = dict["transform"] as? Array<NSNumber> {
                node.transform = deserializeMatrix4(transform)
            }
        }catch{
            os_log("Failed to load file.: %@", log:.default, type:.error, "\(error.localizedDescription)")
        }
    }else{
        os_log("Debug: Only .gltf or .glb files are supported.", log:.default, type:.debug)
    }
    return node
}

fileprivate func createReferenceNode(_ dict: Dictionary<String, Any>) -> SCNReferenceNode {
    let url = dict["url"] as! String
    var referenceUrl : URL
    if let bundleURL = Bundle.main.url(forResource: url, withExtension: nil){
        referenceUrl = bundleURL
    }else{
        referenceUrl = URL(fileURLWithPath: url)
    }
    let node = SCNReferenceNode(url: referenceUrl)
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
