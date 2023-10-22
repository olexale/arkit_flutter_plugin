import ARKit

extension FlutterArkitView {
  func initalize(_ arguments: [String: Any], _: FlutterResult) {
    if let showStatistics = arguments["showStatistics"] as? Bool {
      sceneView.showsStatistics = showStatistics
    }
    
    if let autoenablesDefaultLighting = arguments["autoenablesDefaultLighting"] as? Bool {
      sceneView.autoenablesDefaultLighting = autoenablesDefaultLighting
    }
    
    if let forceUserTapOnCenter = arguments["forceUserTapOnCenter"] as? Bool {
      forceTapOnCenter = forceUserTapOnCenter
    }
    
    initalizeGesutreRecognizers(arguments)
    
    sceneView.debugOptions = parseDebugOptions(arguments)
    configuration = parseConfiguration(arguments)
    if configuration != nil {
      sceneView.session.run(configuration!)
    }
  }
  
  func parseDebugOptions(_ arguments: [String: Any]) -> SCNDebugOptions {
    var options = ARSCNDebugOptions().rawValue
    if let showFeaturePoint = arguments["showFeaturePoints"] as? Bool {
      if showFeaturePoint {
        options |= ARSCNDebugOptions.showFeaturePoints.rawValue
      }
    }
    if let showWorldOrigin = arguments["showWorldOrigin"] as? Bool {
      if showWorldOrigin {
        options |= ARSCNDebugOptions.showWorldOrigin.rawValue
      }
    }
    return ARSCNDebugOptions(rawValue: options)
  }
  
  func parseConfiguration(_ arguments: [String: Any]) -> ARConfiguration? {
    let configurationType = arguments["configuration"] as! Int
    var configuration: ARConfiguration?
    
    switch configurationType {
    case 0:
      configuration = createWorldTrackingConfiguration(arguments)
    case 1:
#if !DISABLE_TRUEDEPTH_API
      configuration = createFaceTrackingConfiguration(arguments)
#else
      logPluginError("TRUEDEPTH_API disabled", toChannel: channel)
#endif
    case 2:
      if #available(iOS 12.0, *) {
        configuration = createImageTrackingConfiguration(arguments)
      } else {
        logPluginError("configuration is not supported on this device", toChannel: channel)
      }
    case 3:
      if #available(iOS 13.0, *) {
        configuration = createBodyTrackingConfiguration(arguments)
      } else {
        logPluginError("configuration is not supported on this device", toChannel: channel)
      }
    default:
      break
    }
    configuration?.worldAlignment = parseWorldAlignment(arguments)
    return configuration
  }
  
  func parseWorldAlignment(_ arguments: [String: Any]) -> ARConfiguration.WorldAlignment {
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
