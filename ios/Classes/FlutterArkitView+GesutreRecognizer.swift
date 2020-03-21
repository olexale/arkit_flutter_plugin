import ARKit

extension FlutterArkitView {
    func initalizeGesutreRecognizers(_ arguments: Dictionary<String, Any>) {
        if let enableTap = arguments["enableTapRecognizer"] as? Bool {
            if (enableTap) {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                self.sceneView.gestureRecognizers?.append(tapGestureRecognizer)
            }
        }
        
        if let enablePinch = arguments["enablePinchRecognizer"] as? Bool{
            if (enablePinch) {
                let tapGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
                self.sceneView.gestureRecognizers?.append(tapGestureRecognizer)
            }
        }
        
        if let enablePan = arguments["enablePanRecognizer"] as? Bool {
            if (enablePan) {
                let tapGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                self.sceneView.gestureRecognizers?.append(tapGestureRecognizer)
            }
        }
    }
    
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        let touchLocation = self.forceTapOnCenter ? self.sceneView.center : recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: nil)
        if (hitResults.count != 0) {
            let nodeName = hitResults.first?.node.name
            self.channel.invokeMethod("onNodeTap", arguments: nodeName)
        }
        
        let arHitResults = getARHitResultsArray(sceneView, atLocation: touchLocation)
        if (arHitResults.count != 0) {
            self.channel.invokeMethod("onARTap", arguments: arHitResults)
        }
    }
    
    @objc func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        if (recognizer.state == .changed) {
            let touchLocation = recognizer.location(in: sceneView)
            let hitResults = sceneView.hitTest(touchLocation, options: nil)
            let results = hitResults.map{["name": $0.node.name as Any, "scale":recognizer.scale] }
            if (results.count != 0) {
                self.channel.invokeMethod("onNodePinch", arguments: results)
            }
        }
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        if (recognizer.state == .changed) {
            let touchLocation = recognizer.location(in: sceneView)
            let translation = recognizer.translation(in: sceneView)
            let hitResults = sceneView.hitTest(touchLocation, options: nil)
            
            let results: Array<Dictionary<String, Any>> = hitResults.compactMap {
                if ($0.node.name != nil) {
                    return ["name" : $0.node.name as Any, "x": translation.x, "y": translation.y]
                }
                return nil
            }
            if (results.count != 0) {
                self.channel.invokeMethod("onNodePan", arguments: results)
            }
        }
    }
    
}
