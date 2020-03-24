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
        let arguments = call.arguments as? Dictionary<String, Any>
        
        if configuration == nil && call.method != "init" {
            logPluginError("plugin is not initialized properly", toChannel: channel)
            result(nil)
            return
        }
        
        switch call.method {
        case "init":
            initalize(arguments!, result)
            result(nil)
            break
        case "addARKitNode":
            onAddNode(arguments!)
            result(nil)
            break
        case "removeARKitNode":
            onRemoveNode(arguments!)
            result(nil)
            break
        case "getNodeBoundingBox":
            onGetNodeBoundingBox(arguments!, result)
            break
        case "positionChanged":
            onPositionChanged(arguments!)
            result(nil)
            break
        case "rotationChanged":
            onRotationChanged(arguments!)
            result(nil)
            break
        case "eulerAnglesChanged":
            onEulerAnglesChanged(arguments!)
            result(nil)
            break
        case "scaleChanged":
            onScaleChanged(arguments!)
            result(nil)
            break
        case "updateSingleProperty":
            onUpdateSingleProperty(arguments!)
            result(nil)
            break
        case "updateMaterials":
            onUpdateMaterials(arguments!)
            result(nil)
            break
        case "performHitTest":
            onPerformHitTest(arguments!, result)
            break
        case "updateFaceGeometry":
            onUpdateFaceGeometry(arguments!)
            result(nil)
            break
        case "getLightEstimate":
            onGetLightEstimate(result)
            result(nil)
            break
        case "projectPoint":
            onProjectPoint(arguments!, result)
            break
        case "cameraProjectionMatrix":
            onCameraProjectionMatrix(result)
            break
        case "playAnimation":
            onPlayAnimation(arguments!)
            result(nil)
            break
        case "stopAnimation":
            onStopAnimation(arguments!)
            result(nil)
            break
        case "dispose":
            onDispose(result)
            result(nil)
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
