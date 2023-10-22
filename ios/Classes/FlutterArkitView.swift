import ARKit
import Foundation

class FlutterArkitView: NSObject, FlutterPlatformView {
  let sceneView: ARSCNView
  let channel: FlutterMethodChannel
  
  var forceTapOnCenter: Bool = false
  var configuration: ARConfiguration? = nil
  
  init(withFrame frame: CGRect, viewIdentifier viewId: Int64, messenger msg: FlutterBinaryMessenger) {
    sceneView = ARSCNView(frame: frame)
    channel = FlutterMethodChannel(name: "arkit_\(viewId)", binaryMessenger: msg)
    
    super.init()
    
    sceneView.delegate = self
    channel.setMethodCallHandler(onMethodCalled)
  }
  
  func view() -> UIView { return sceneView }
  
  func onMethodCalled(_ call: FlutterMethodCall, _ result: FlutterResult) {
    let arguments = call.arguments as? [String: Any]
    
    if configuration == nil && call.method != "init" {
      logPluginError("plugin is not initialized properly", toChannel: channel)
      result(nil)
      return
    }
    
    switch call.method {
    case "init":
      initalize(arguments!, result)
      result(nil)
    case "addARKitNode":
      onAddNode(arguments!)
      result(nil)
    case "onUpdateNode":
      onUpdateNode(arguments!)
      result(nil)
    case "removeARKitNode":
      onRemoveNode(arguments!)
      result(nil)
    case "removeARKitAnchor":
      onRemoveAnchor(arguments!)
      result(nil)
    case "addCoachingOverlay":
      if #available(iOS 13.0, *) {
        addCoachingOverlay(arguments!)
      }
      result(nil)
    case "removeCoachingOverlay":
      if #available(iOS 13.0, *) {
        removeCoachingOverlay()
      }
      result(nil)
    case "getNodeBoundingBox":
      onGetNodeBoundingBox(arguments!, result)
    case "transformationChanged":
      onTransformChanged(arguments!)
      result(nil)
    case "isHiddenChanged":
      onIsHiddenChanged(arguments!)
      result(nil)
    case "updateSingleProperty":
      onUpdateSingleProperty(arguments!)
      result(nil)
    case "updateMaterials":
      onUpdateMaterials(arguments!)
      result(nil)
    case "performHitTest":
      onPerformHitTest(arguments!, result)
    case "updateFaceGeometry":
      onUpdateFaceGeometry(arguments!)
      result(nil)
    case "getLightEstimate":
      onGetLightEstimate(result)
      result(nil)
    case "projectPoint":
      onProjectPoint(arguments!, result)
    case "cameraProjectionMatrix":
      onCameraProjectionMatrix(result)
    case "pointOfViewTransform":
      onPointOfViewTransform(result)
    case "playAnimation":
      onPlayAnimation(arguments!)
      result(nil)
    case "stopAnimation":
      onStopAnimation(arguments!)
      result(nil)
    case "dispose":
      onDispose(result)
      result(nil)
    case "cameraEulerAngles":
      onCameraEulerAngles(result)
    case "snapshot":
      onGetSnapshot(result)
    case "cameraPosition":
      onGetCameraPosition(result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  func sendToFlutter(_ method: String, arguments: Any?) {
    DispatchQueue.main.async {
      self.channel.invokeMethod(method, arguments: arguments)
    }
  }
  
  func onDispose(_ result: FlutterResult) {
    sceneView.session.pause()
    channel.setMethodCallHandler(nil)
    result(nil)
  }
}
