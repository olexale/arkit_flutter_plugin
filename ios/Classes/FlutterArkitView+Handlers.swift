import ARKit

extension FlutterArkitView {
    func onAddNode(_ arguments: [String: Any]) {
        let geometryArguments = arguments["geometry"] as? [String: Any]
        let geometry = createGeometry(geometryArguments, withDevice: sceneView.device)
        let node = createNode(geometry, fromDict: arguments, forDevice: sceneView.device, channel: channel)
        if let parentNodeName = arguments["parentNodeName"] as? String {
            let parentNode = sceneView.scene.rootNode.childNode(withName: parentNodeName, recursively: true)
            parentNode?.addChildNode(node)
        } else {
            sceneView.scene.rootNode.addChildNode(node)
        }
    }

    func onUpdateNode(_ arguments: [String: Any]) {
        guard let nodeName = arguments["nodeName"] as? String else {
            logPluginError("nodeName deserialization failed", toChannel: channel)
            return
        }
        guard let node = sceneView.scene.rootNode.childNode(withName: nodeName, recursively: true) else {
            logPluginError("node not found", toChannel: channel)
            return
        }
        if let geometryArguments = arguments["geometry"] as? [String: Any],
           let geometry = createGeometry(geometryArguments, withDevice: sceneView.device)
        {
            node.geometry = geometry
        }
        if let materials = arguments["materials"] as? [[String: Any]] {
            node.geometry?.materials = parseMaterials(materials)
        }
        updateNode(node, fromDict: arguments, forDevice: sceneView.device)
    }

    func onRemoveNode(_ arguments: [String: Any]) {
        guard let nodeName = arguments["nodeName"] as? String else {
            logPluginError("nodeName deserialization failed", toChannel: channel)
            return
        }
        let node = sceneView.scene.rootNode.childNode(withName: nodeName, recursively: true)
        node?.removeFromParentNode()
    }

    func onRemoveAnchor(_ arguments: [String: Any]) {
        guard let anchorIdentifier = arguments["anchorIdentifier"] as? String else {
            logPluginError("anchorIdentifier deserialization failed", toChannel: channel)
            return
        }
        if let anchor = sceneView.session.currentFrame?.anchors.first(where: { $0.identifier.uuidString == anchorIdentifier }) {
            sceneView.session.remove(anchor: anchor)
        }
    }

    func onGetNodeBoundingBox(_ arguments: [String: Any], _ result: FlutterResult) {
        guard let name = arguments["name"] as? String
        else {
            logPluginError("name not found: failed", toChannel: channel)
            return
        }
        if let node = sceneView.scene.rootNode.childNode(withName: name, recursively: true) {
            let resArray = [serializeVector(node.boundingBox.min), serializeVector(node.boundingBox.max)]
            result(resArray)
        } else {
            logPluginError("node \(name) not found", toChannel: channel)
        }
    }

    func onTransformChanged(_ arguments: [String: Any]) {
        guard let name = arguments["name"] as? String,
              let params = arguments["transformation"] as? [NSNumber]
        else {
            logPluginError("deserialization failed", toChannel: channel)
            return
        }
        if let node = sceneView.scene.rootNode.childNode(withName: name, recursively: true) {
            node.transform = deserializeMatrix4(params)
        } else {
            logPluginError("node \(name) not found", toChannel: channel)
        }
    }

    func onIsHiddenChanged(_ arguments: [String: Any]) {
        guard let name = arguments["name"] as? String,
              let params = arguments["isHidden"] as? Bool
        else {
            logPluginError("deserialization failed", toChannel: channel)
            return
        }
        if let node = sceneView.scene.rootNode.childNode(withName: name, recursively: true) {
            node.isHidden = params
        } else {
            logPluginError("node not found", toChannel: channel)
        }
    }

    func onUpdateSingleProperty(_ arguments: [String: Any]) {
        guard let name = arguments["name"] as? String,
              let args = arguments["property"] as? [String: Any],
              let propertyName = args["propertyName"] as? String,
              let propertyValue = args["propertyValue"],
              let keyProperty = args["keyProperty"] as? String
        else {
            logPluginError("deserialization failed", toChannel: channel)
            return
        }

        if let node = sceneView.scene.rootNode.childNode(withName: name, recursively: true) {
            if let obj = node.value(forKey: keyProperty) as? NSObject {
                obj.setValue(propertyValue, forKey: propertyName)
            } else {
                logPluginError("value is not a NSObject", toChannel: channel)
            }
        } else {
            logPluginError("node not found", toChannel: channel)
        }
    }

    func onUpdateMaterials(_ arguments: [String: Any]) {
        guard let name = arguments["name"] as? String,
              let rawMaterials = arguments["materials"] as? [[String: Any]]
        else {
            logPluginError("deserialization failed", toChannel: channel)
            return
        }
        if let node = sceneView.scene.rootNode.childNode(withName: name, recursively: true) {
            let materials = parseMaterials(rawMaterials)
            node.geometry?.materials = materials
        } else {
            logPluginError("node not found", toChannel: channel)
        }
    }

    func onUpdateFaceGeometry(_ arguments: [String: Any]) {
        #if !DISABLE_TRUEDEPTH_API
            guard let name = arguments["name"] as? String,
                  let param = arguments["geometry"] as? [String: Any],
                  let fromAnchorId = param["fromAnchorId"] as? String
            else {
                logPluginError("deserialization failed", toChannel: channel)
                return
            }
            if let node = sceneView.scene.rootNode.childNode(withName: name, recursively: true),
               let geometry = node.geometry as? ARSCNFaceGeometry,
               let anchor = sceneView.session.currentFrame?.anchors.first(where: { $0.identifier.uuidString == fromAnchorId }) as? ARFaceAnchor
            {
                geometry.update(from: anchor.geometry)
            } else {
                logPluginError("node not found, geometry was empty, or anchor not found", toChannel: channel)
            }
        #else
            logPluginError("TRUEDEPTH_API disabled", toChannel: channel)
        #endif
    }

    func onPerformHitTest(_ arguments: [String: Any], _ result: FlutterResult) {
        guard let x = arguments["x"] as? Double,
              let y = arguments["y"] as? Double
        else {
            logPluginError("deserialization failed", toChannel: channel)
            result(nil)
            return
        }
        let viewWidth = sceneView.bounds.size.width
        let viewHeight = sceneView.bounds.size.height
        let location = CGPoint(x: viewWidth * CGFloat(x), y: viewHeight * CGFloat(y))
        let arHitResults = getARHitResultsArray(sceneView, atLocation: location)
        result(arHitResults)
    }

    func onGetLightEstimate(_ result: FlutterResult) {
        let frame = sceneView.session.currentFrame
        if let lightEstimate = frame?.lightEstimate {
            let res = ["ambientIntensity": lightEstimate.ambientIntensity, "ambientColorTemperature": lightEstimate.ambientColorTemperature]
            result(res)
        } else {
            result(nil)
        }
    }

    func onProjectPoint(_ arguments: [String: Any], _ result: FlutterResult) {
        guard let rawPoint = arguments["point"] as? [Double] else {
            logPluginError("deserialization failed", toChannel: channel)
            result(nil)
            return
        }
        let point = deserizlieVector3(rawPoint)
        let projectedPoint = sceneView.projectPoint(point)
        let res = serializeVector(projectedPoint)
        result(res)
    }

    func onCameraProjectionMatrix(_ result: FlutterResult) {
        if let frame = sceneView.session.currentFrame {
            let matrix = serializeMatrix(frame.camera.projectionMatrix)
            result(matrix)
        } else {
            result(nil)
        }
    }

    func onPointOfViewTransform(_ result: FlutterResult) {
        if let pointOfView = sceneView.pointOfView {
            let matrix = serializeMatrix(pointOfView.simdWorldTransform)
            result(matrix)
        } else {
            result(nil)
        }
    }

    func onPlayAnimation(_ arguments: [String: Any]) {
        guard let key = arguments["key"] as? String,
              let sceneName = arguments["sceneName"] as? String,
              let animationIdentifier = arguments["animationIdentifier"] as? String
        else {
            logPluginError("deserialization failed", toChannel: channel)
            return
        }

        if let sceneUrl = Bundle.main.url(forResource: sceneName, withExtension: "dae"),
           let sceneSource = SCNSceneSource(url: sceneUrl, options: nil),
           let animation = sceneSource.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self)
        {
            animation.repeatCount = 1
            animation.fadeInDuration = 1
            animation.fadeOutDuration = 0.5
            sceneView.scene.rootNode.addAnimation(animation, forKey: key)
        } else {
            logPluginError("animation failed", toChannel: channel)
        }
    }

    func onStopAnimation(_ arguments: [String: Any]) {
        guard let key = arguments["key"] as? String else {
            logPluginError("deserialization failed", toChannel: channel)
            return
        }
        sceneView.scene.rootNode.removeAnimation(forKey: key)
    }

    func onCameraEulerAngles(_ result: FlutterResult) {
        if let frame = sceneView.session.currentFrame {
            let res = serializeArray(frame.camera.eulerAngles)
            result(res)
        } else {
            result(nil)
        }
    }

    func onCameraIntrinsics(_ result: FlutterResult) {
        if let frame = sceneView.session.currentFrame {
            let res = serializeMatrix3x3(frame.camera.intrinsics)
            result(res)
        } else {
            result(nil)
        }
    }

    func onCameraImageResolution(_ result: FlutterResult) {
        if let frame = sceneView.session.currentFrame {
            let res = serializeSize(frame.camera.imageResolution)
            result(res)
        } else {
            result(nil)
        }
    }

    func onCameraCapturedImage(_ result: FlutterResult) {
        if let frame = sceneView.session.currentFrame {
            if let bytes = UIImage(ciImage: CIImage(cvPixelBuffer: frame.capturedImage)).pngData() {
                let res = FlutterStandardTypedData(bytes: bytes)
                result(res)
            } else {
                result(nil)
            }
        } else {
            result(nil)
        }
    }

    func onGetSnapshot(_ result: FlutterResult) {
        let snapshotImage = sceneView.snapshot()
        if let bytes = snapshotImage.pngData() {
            let data = FlutterStandardTypedData(bytes: bytes)
            result(data)
        } else {
            result(nil)
        }
    }

    func onGetSnapshotWithDepthData(_ result: FlutterResult) {
        if #available(iOS 14.0, *) {
            if let currentFrame = sceneView.session.currentFrame, let depthData = currentFrame.sceneDepth {
                let originalImage = currentFrame.capturedImage
                let ciImage = CIImage(cvPixelBuffer: originalImage)
                let ciContext = CIContext()
                let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)!
                let image = UIImage(cgImage: cgImage)
                let convertedImage = image.jpegData(compressionQuality: 1)!
                let imageData = FlutterStandardTypedData(bytes: convertedImage)

                let depthDataMap = depthData.depthMap

                CVPixelBufferLockBaseAddress(depthDataMap, CVPixelBufferLockFlags(rawValue: 0))

                let depthWidth = CVPixelBufferGetWidth(depthDataMap)
                let depthHeight = CVPixelBufferGetHeight(depthDataMap)

                let floatBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(depthDataMap), to: UnsafeMutablePointer<Float32>.self)

                CVPixelBufferUnlockBaseAddress(depthDataMap, CVPixelBufferLockFlags(rawValue: 0))

                let intrinsics = currentFrame.camera.intrinsics
                let intrinsicsString = String(
                    format: "%f,%f,%f-%f,%f,%f-%f,%f,%f",
                    intrinsics.columns.0.x, intrinsics.columns.0.y, intrinsics.columns.0.z,
                    intrinsics.columns.1.x, intrinsics.columns.1.y, intrinsics.columns.1.z,
                    intrinsics.columns.2.x, intrinsics.columns.2.y, intrinsics.columns.2.z
                )

                let depthArray = Array(UnsafeBufferPointer(start: floatBuffer, count: depthWidth * depthHeight)).map { $0.isNaN ? -1 : $0 }

                let data: [String: Any] = [
                    "image": imageData,
                    "intrinsics": intrinsicsString,
                    "depthWidth": depthWidth,
                    "depthHeight": depthHeight,
                    "depthMap": depthArray,
                ]

                result(data)
            } else {
                result(nil)
            }
        } else {
            result(nil)
        }
    }

    func onGetCameraPosition(_ result: FlutterResult) {
        if let frame: ARFrame = sceneView.session.currentFrame {
            let cameraPosition = frame.camera.transform.columns.3
            let res = serializeArray(cameraPosition)
            result(res)
        } else {
            result(nil)
        }
    }
}
