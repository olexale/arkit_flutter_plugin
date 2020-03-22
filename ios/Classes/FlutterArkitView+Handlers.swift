import ARKit

extension FlutterArkitView {
    func onAddNode(_ arguments: Dictionary<String, Any>) {
        guard let geometryArguments = arguments["geometry"] as? Dictionary<String, Any> else {
            logPluginError("onAddNode geometryArguments deserialization failed", toChannel: channel)
            return
        }
        let geometry = createGeometry(geometryArguments, withDevice: sceneView.device)
        let node = createNode(geometry, fromDict: arguments, forDevice: sceneView.device)
        if let parentNodeName = arguments["parentNodeName"] as? String {
            let parentNode = sceneView.scene.rootNode.childNode(withName: parentNodeName, recursively: true)
            parentNode?.addChildNode(node)
        } else {
            sceneView.scene.rootNode.addChildNode(node)
        }
    }
    
    func onRemoveNode(_ arguments: Dictionary<String, Any>) {
        guard let nodeName = arguments["nodeName"] as? String else {
            logPluginError("onRemoveNode nodeName deserialization failed", toChannel: channel)
            return
        }
        let node = sceneView.scene.rootNode.childNode(withName: nodeName, recursively: true)
        node?.removeFromParentNode()
    }
    
    func onGetNodeBoundingBox(_ arguments: Dictionary<String, Any>, _ result:FlutterResult) {
        guard let geometryArguments = arguments["geometry"] as? Dictionary<String, Any> else {
            logPluginError("onGetNodeBoundingBox geometryArguments deserialization failed", toChannel: channel)
            return
        }
        let geometry = createGeometry(geometryArguments, withDevice: sceneView.device)
        let node = createNode(geometry, fromDict: arguments, forDevice: sceneView.device)
        
        let resArray = [serlializeVector(node.boundingBox.min), serlializeVector(node.boundingBox.max)]
        result(resArray)
    }
    
    
}
