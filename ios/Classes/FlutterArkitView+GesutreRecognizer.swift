import ARKit

extension FlutterArkitView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        return true
    }

    func initalizeGesutreRecognizers(_ arguments: [String: Any]) {
        if let enableTap = arguments["enableTapRecognizer"] as? Bool {
            if enableTap {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                tapGestureRecognizer.delegate = self
                sceneView.gestureRecognizers?.append(tapGestureRecognizer)
            }
        }

        if let enablePinch = arguments["enablePinchRecognizer"] as? Bool {
            if enablePinch {
                let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
                pinchGestureRecognizer.delegate = self
                sceneView.gestureRecognizers?.append(pinchGestureRecognizer)
            }
        }

        if let enablePan = arguments["enablePanRecognizer"] as? Bool {
            if enablePan {
                let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                panGestureRecognizer.delegate = self
                sceneView.gestureRecognizers?.append(panGestureRecognizer)
            }
        }

        if let enableRotation = arguments["enableRotationRecognizer"] as? Bool {
            if enableRotation {
                let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
                rotationGestureRecognizer.delegate = self
                sceneView.gestureRecognizers?.append(rotationGestureRecognizer)
            }
        }
    }

    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        let touchLocation = forceTapOnCenter ? sceneView.center : recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: nil)

        // Collect tapped node information
        let nodeInfo: [String] = hitResults.compactMap { hitResult in
            var targetNode = hitResult.node
            var walkerNode = targetNode

            // ARKit gives the most specific node name it can. When that is a loaded model
            // this means the node name is not unique. Walk up the parent nodes and look for
            // an SCNReferenceNode, this will be the node the calling code created.
            while let parent = walkerNode.parent {
                let retainedParent = parent
                if retainedParent is SCNReferenceNode {
                    targetNode = retainedParent
                    break
                }
                walkerNode = retainedParent
            }

            return targetNode.name
        }

        if !nodeInfo.isEmpty {
            let uniqueNodeInfo = Array(Set(nodeInfo))
            sendToFlutter("onNodeTap", arguments: uniqueNodeInfo)
        }

        let arHitResults = getARHitResultsArray(sceneView, atLocation: touchLocation)
        if !arHitResults.isEmpty {
            sendToFlutter("onARTap", arguments: arHitResults)
        }
    }

    @objc func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        if recognizer.state == .changed {
            let touchLocation = recognizer.location(in: sceneView)
            let hitResults = sceneView.hitTest(touchLocation, options: nil)
            let results: [[String: Any]] = hitResults.compactMap {
                if let name = $0.node.name {
                    return ["nodeName": name, "scale": recognizer.scale]
                } else {
                    return nil
                }
            }
            if results.count != 0 {
                sendToFlutter("onNodePinch", arguments: results)
            }
        }
    }

    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        if recognizer.state == .changed {
            let touchLocation = recognizer.location(in: sceneView)
            let translation = recognizer.translation(in: sceneView)
            let hitResults = sceneView.hitTest(touchLocation, options: nil)

            let results: [[String: Any]] = hitResults.compactMap {
                if let name = $0.node.name {
                    return ["nodeName": name,
                            "translation": [translation.x, translation.y]]
                } else {
                    return nil
                }
            }
            if results.count != 0 {
                sendToFlutter("onNodePan", arguments: results)
            }
        }
    }

    @objc func handleRotation(_ recognizer: UIRotationGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        if recognizer.state == .changed {
            let touchLocation = recognizer.location(in: sceneView)
            let hitResults = sceneView.hitTest(touchLocation, options: nil)

            let results: [[String: Any]] = hitResults.compactMap {
                if let name = $0.node.name {
                    return ["nodeName": name, "rotation": recognizer.rotation]
                } else {
                    return nil
                }
            }
            if results.count != 0 {
                sendToFlutter("onNodeRotation", arguments: results)
            }
            recognizer.rotation = 0
        }
    }
}
