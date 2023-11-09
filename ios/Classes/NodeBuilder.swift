import ARKit
import GLTFSceneKit
import SCNLine

func createNode(_ geometry: SCNGeometry?, fromDict dict: [String: Any], forDevice device: MTLDevice?, channel: FlutterMethodChannel) -> SCNNode {
  let dartType = dict["dartType"] as! String
  let node: SCNNode
  
  switch dartType {
  case "ARKitLineNode":
    node = createSCNLineNode(dict)
  case "ARKitReferenceNode":
    node = createReferenceNode(dict)
  case "ARKitGltfNode":
    node = createGltfNode(dict, channel: channel)
  default:
    node = SCNNode(geometry: geometry)
  }
  
  updateNode(node, fromDict: dict, forDevice: device)
  return node
}

func updateNode(_ node: SCNNode, fromDict dict: [String: Any], forDevice device: MTLDevice?) {
  if let transform = dict["transform"] as? [NSNumber] {
    node.transform = deserializeMatrix4(transform)
  }
  
  if let name = dict["name"] as? String {
    node.name = name
  }
  
  if let physicsBody = dict["physicsBody"] as? [String: Any] {
    node.physicsBody = createPhysicsBody(physicsBody, forDevice: device)
  }
  
  if let light = dict["light"] as? [String: Any] {
    node.light = createLight(light)
  }
  
  if let renderingOrder = dict["renderingOrder"] as? Int {
    node.renderingOrder = renderingOrder
  }
  
  if let isHidden = dict["isHidden"] as? Bool {
    node.isHidden = isHidden
  }
}

fileprivate func createSCNLineNode(_ dict: Dictionary<String, Any>) -> SCNNode {

    let radius = dict["radius"] as! Double
    let edges = dict["edges"] as! Int
    let maxTurning = dict["maxTurning"] as! Int
    let node = SCNLineNode(with: [], radius: Float(radius), edges: edges, maxTurning: maxTurning)

    if let materials = dict["materials"] as? [[String: Any]] {
        node.lineMaterials = parseMaterials(materials)
    }else{
        let material = SCNMaterial()
        material.diffuse.contents = UIColor(
            displayP3Red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
        material.isDoubleSided = true
        node.lineMaterials = [material]
    }
    return node
}

func updateLineNode(_ sceneView: ARSCNView, _ node: SCNLineNode, fromDict dict: Dictionary<String, Any>, channel: FlutterMethodChannel) {
    let x = dict["x"] as! Double
    let y = dict["y"] as! Double
    let touchPoint = CGPoint(x: x, y: y);
    var floorNode = sceneView.pointOfView?.childNode(withName: "floorNode", recursively: false)
    if(floorNode == nil){
        floorNode = SCNNode(geometry: SCNFloor())
        floorNode!.name = "floorNode"
        floorNode!.isHidden = true
        sceneView.pointOfView?.addChildNode(floorNode!)
        floorNode!.position.z = -0.5
        floorNode!.eulerAngles.x = -.pi / 2
    }
    guard let lastHit = sceneView.hitTest(touchPoint, options: [
        SCNHitTestOption.rootNode: floorNode!, SCNHitTestOption.ignoreHiddenNodes: false
    ]).first else {
        logPluginError("Failed to get HitTestResult", toChannel: channel)
        return
    }
    
    let worldCoordinates = lastHit.worldCoordinates
    var lastPoint = SCNVector3Zero
    if(!node.points.isEmpty){
        lastPoint = node.points.last!
    }
    
    let diff = SCNVector3(worldCoordinates.x - lastPoint.x, worldCoordinates.y - lastPoint.y, worldCoordinates.z - lastPoint.z)
    let distance = sqrt(diff.x * diff.x + diff.y * diff.y + diff.z * diff.z)
    print("distance : " + String(distance))
    if distance > 0.012 {
        node.add(point: worldCoordinates)
    }
}

private func createGltfNode(_ dict: [String: Any], channel: FlutterMethodChannel) -> SCNNode {
  let url = dict["url"] as! String
  let urlLowercased = url.lowercased()
  let node = SCNNode()
  
  if urlLowercased.hasSuffix(".gltf") || urlLowercased.hasSuffix(".glb") {
    let assetTypeIndex = dict["assetType"] as? Int
    let isFromFlutterAssets = assetTypeIndex == 0
    let sceneSource: GLTFSceneSource
    
    do {
      if isFromFlutterAssets {
        // load model from Flutter assets
        let modelPath = FlutterDartProject.lookupKey(forAsset: url)
        sceneSource = try GLTFSceneSource(named: modelPath)
      } else {
        // load model from the Documents folder
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let modelPath = documentsDirectory.appendingPathComponent(url).path
        sceneSource = try GLTFSceneSource(path: modelPath)
      }
      let scene = try sceneSource.scene()
      
      for child in scene.rootNode.childNodes {
        node.addChildNode(child.flattenedClone())
      }
      
      if let name = dict["name"] as? String {
        node.name = name
      }
      if let transform = dict["transform"] as? [NSNumber] {
        node.transform = deserializeMatrix4(transform)
      }
    } catch {
      logPluginError("Failed to load file: \(error.localizedDescription)", toChannel: channel)
    }
  } else {
    logPluginError("Only .gltf or .glb files are supported.", toChannel: channel)
  }
  return node
}

private func createReferenceNode(_ dict: [String: Any]) -> SCNReferenceNode {
  let url = dict["url"] as! String
  let referenceUrl: URL
  if let bundleURL = Bundle.main.url(forResource: url, withExtension: nil) {
    referenceUrl = bundleURL
  } else {
    referenceUrl = URL(fileURLWithPath: url)
  }
  let node = SCNReferenceNode(url: referenceUrl)
  node?.load()
  return node!
}

private func createPhysicsBody(_ dict: [String: Any], forDevice device: MTLDevice?) -> SCNPhysicsBody {
  var shape: SCNPhysicsShape?
  if let shapeDict = dict["shape"] as? [String: Any],
     let shapeGeometry = shapeDict["geometry"] as? [String: Any]
  {
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

private func createLight(_ dict: [String: Any]) -> SCNLight {
  let light = SCNLight()
  if let type = dict["type"] as? Int {
    switch type {
    case 0:
      light.type = .ambient
    case 1:
      light.type = .omni
    case 2:
      light.type = .directional
    case 3:
      light.type = .spot
    case 4:
      light.type = .IES
    case 5:
      light.type = .probe
    case 6:
      if #available(iOS 13.0, *) {
        light.type = .area
      } else {
        // error
        light.type = .omni
      }
    default:
      light.type = .omni
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
