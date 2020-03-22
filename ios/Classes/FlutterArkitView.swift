import Foundation
import ARKit

class FlutterArkitView: NSObject, FlutterPlatformView {
    let sceneView: ARSCNView
    let channel: FlutterMethodChannel
    
    var forceTapOnCenter: Bool = false
    var configuration: ARConfiguration? = nil
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, messenger msg: FlutterBinaryMessenger) {
        self.sceneView = ARSCNView(frame: frame)
        self.channel = FlutterMethodChannel(name: "arkit_\(viewId)", binaryMessenger: msg)
        
        super.init()
        
        self.sceneView.delegate = self
        self.channel.setMethodCallHandler(self.onMethodCalled)
    }
    
    func view() -> UIView { return sceneView }
    
    func onMethodCalled(_ call :FlutterMethodCall, _ result:FlutterResult) {
        switch call.method {
        case "init":
            initalize(call, result)
            break
        case "addARKitNode":
            onAddNode(call, result)
            break
        case "removeARKitNode": break
        case "getNodeBoundingBox": break
        case "positionChanged": break
        case "rotationChanged": break
        case "eulerAnglesChanged": break
        case "scaleChanged": break
        case "updateSingleProperty" :break
        case "updateMaterials": break
        case "performHitTest": break
        case "updateFaceGeometry": break
        case "getLightEstimate": break
        case "projectPoint": break
        case "cameraProjectionMatrix": break
        case "playAnimation": break
        case "stopAnimation": break
        case "dispose":
            onDispose(result)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
    
    func onDispose(_ result:FlutterResult) {
        sceneView.session.pause()
        result(nil)
    }
    
}
