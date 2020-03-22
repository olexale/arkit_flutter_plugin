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
        guard let arguments = call.arguments as? Dictionary<String, Any> else {
            logPluginError("onMethodCalled arguments deserialization failed", toChannel: channel)
            result(nil)
            return
        }
        
        switch call.method {
        case "init":
            initalize(arguments, result)
            result(nil)
            break
        case "addARKitNode":
            onAddNode(arguments)
            result(nil)
            break
        case "removeARKitNode":
            onRemoveNode(arguments)
            result(nil)
            break
        case "getNodeBoundingBox":
            onGetNodeBoundingBox(arguments, result)
            break
        case "positionChanged":
//            onPositionChanged(arguments)
            break
        case "rotationChanged":
//            onRotationChanged(arguments)
            break
        case "eulerAnglesChanged":
//            onEulerAnglesChanged(arguments)
            break
        case "scaleChanged":
//            onScaleChanged(arguments)
            break
        case "updateSingleProperty":
//            onUpdateSingleProperty(arguments)
            break
        case "updateMaterials":
//            onUpdateMaterials(arguments)
            break
        case "performHitTest":
//            onPerformHitTest(arguments)
            break
        case "updateFaceGeometry":
//            onUpdateFaceGeometry(arguments)
            break
        case "getLightEstimate":
//            onGetLightEstimate(arguments)
            break
        case "projectPoint":
//            onProjectPoint(arguments)
            break
        case "cameraProjectionMatrix":
//            onCameraProjectionMatrix(arguments)
            break
        case "playAnimation":
//            onPlayAnimation(arguments)
            break
        case "stopAnimation":
//            onStopAnimation(arguments)
            break
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
