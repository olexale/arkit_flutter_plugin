import ARKit

extension FlutterArkitView {
    func initalize(_ arguments: Dictionary<String, Any>, _ result:FlutterResult) {
        if let showStatistics = arguments["showStatistics"] as? Bool {
            self.sceneView.showsStatistics = showStatistics
        }
        
        if let autoenablesDefaultLighting = arguments["autoenablesDefaultLighting"] as? Bool {
            self.sceneView.autoenablesDefaultLighting = autoenablesDefaultLighting
        }
        
        if let forceUserTapOnCenter = arguments["forceUserTapOnCenter"] as? Bool {
            self.forceTapOnCenter = forceUserTapOnCenter
        }
        
        initalizeGesutreRecognizers(arguments)
        
        sceneView.debugOptions = parseDebugOptions(arguments)
        configuration = parseConfiguration(arguments)
        if (configuration != nil) {
            self.sceneView.session.run(self.configuration!)
        }
    }
    
    func parseDebugOptions(_ arguments: Dictionary<String, Any>) -> SCNDebugOptions {
        var options = ARSCNDebugOptions().rawValue
        if let showFeaturePoint = arguments["showFeaturePoints"] as? Bool {
            if (showFeaturePoint) {
                options |= ARSCNDebugOptions.showFeaturePoints.rawValue
            }
        }
        if let showWorldOrigin = arguments["showWorldOrigin"] as? Bool {
            if (showWorldOrigin) {
                options |= ARSCNDebugOptions.showWorldOrigin.rawValue
            }
        }
        return ARSCNDebugOptions(rawValue: options)
    }
    
    func parseConfiguration(_ arguments: Dictionary<String, Any>) -> ARConfiguration? {
        let configurationType = arguments["configuration"] as! Int
        var configuration: ARConfiguration? = nil
        
        switch configurationType {
        case 0:
            configuration = createWorldTrackingConfiguration(arguments)
            break
        case 1:
            #if !DISABLE_TRUEDEPTH_API
            configuration = createFaceTrackingConfiguration(arguments)
            #else
            logPluginError("TRUEDEPTH_API disabled", toChannel: channel)
            #endif
            break
        case 2:
            if #available(iOS 12.0, *) {
                configuration = createImageTrackingConfiguration(arguments)
            } else {
                logPluginError("configuration is not supported on this device", toChannel: channel)
            }
            break
        case 3:
            if #available(iOS 13.0, *) {
                configuration = createBodyTrackingConfiguration(arguments)
            } else {
                logPluginError("configuration is not supported on this device", toChannel: channel)
            }
            break
        default:
            break
        }
        configuration?.worldAlignment = parseWorldAlignment(arguments)
        return configuration
    }
    
    func parseWorldAlignment(_ arguments: Dictionary<String, Any>) -> ARConfiguration.WorldAlignment {
        if let worldAlignment = arguments["worldAlignment"] as? Int {
            if worldAlignment == 0 {
                return .gravity
            }
            if worldAlignment == 1 {
                return .gravityAndHeading
            }
        }
        return .camera
    }
}
