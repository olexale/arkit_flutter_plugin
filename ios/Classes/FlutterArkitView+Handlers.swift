import ARKit

extension FlutterArkitView {
    func onAddNode(_ call :FlutterMethodCall, _ result:FlutterResult) {
        guard
            let arguments = call.arguments as? Dictionary<String, Any>,
            let geometryArguments = arguments["geometry"] as? Dictionary<String, Any> else {
                // fail
                result(nil)
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
        
        result(nil)
    }
}
