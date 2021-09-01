import Foundation
import ARKit
import Flutter

class OnAddNode {
    var function: ((_ arguments: Dictionary<String, Any>) -> Void)?
    var arguments: Dictionary<String, Any>
    
    init(function: ((_ arguments: Dictionary<String, Any>) -> Void)?, arguments: Dictionary<String, Any>) {
        self.function = function
        self.arguments = arguments
    }
    
    func execute() {
        self.function?(arguments)
    }
}

class FlutterArkitView: NSObject, FlutterPlatformView {
    
    let sceneView: ARSCNView
    let channel: FlutterMethodChannel
    
    var forceTapOnCenter: Bool = false
    var isCoachingOverlayActive: Bool = false
    var configuration: ARConfiguration? = nil
    
    var actions: [OnAddNode] = []
    var shouldShowCoachingOverlay: Bool = false
    @available(iOS 13, *)
    private(set) lazy var coachingView: ARCoachingOverlayView = ARCoachingOverlayView(frame: self.sceneView.frame)
        
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
            if (isCoachingOverlayActive || shouldShowCoachingOverlay) {
                self.actions.append(OnAddNode(function: onAddNode(_:), arguments: arguments!))
            } else {
                onAddNode(arguments!)
            }
            result(nil)
            break
        case "onUpdateNode":
            onUpdateNode(arguments!)
            result(nil)
            break
        case "removeARKitNode":
            onRemoveNode(arguments!)
            result(nil)
            break
        case "removeARKitAnchor":
            onRemoveAnchor(arguments!)
            result(nil)
            break
        case "getNodeBoundingBox":
            onGetNodeBoundingBox(arguments!, result)
            break
        case "transformationChanged":
            onTransformChanged(arguments!)
            result(nil)
            break
        case "isHiddenChanged":
            onIsHiddenChanged(arguments!)
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
        case "pointOfViewTransform":
            onPointOfViewTransform(result)
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
        case "cameraEulerAngles":
            onCameraEulerAngles(result)
            break
        case "snapshot":
            onGetSnapshot(result)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
    
    func onDispose(_ result:FlutterResult) {
        sceneView.session.pause()
        self.channel.setMethodCallHandler(nil)
        result(nil)
    }
    
    func executeActions() {
        for addFunction in actions {
            addFunction.execute()
        }
        actions.removeAll()
        
    }
}

@available(iOS 13.0, *)
extension FlutterArkitView: ARCoachingOverlayViewDelegate {
    func addCoachingOverlay() {
        
        isCoachingOverlayActive = true
        
        coachingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        sceneView.subviews.forEach({ ($0 as? ARCoachingOverlayView)?.removeFromSuperview()})
        
        sceneView.addSubview(coachingView)
        
        coachingView.goal = .verticalPlane
        coachingView.session = self.sceneView.session
        coachingView.delegate = self
        coachingView.setActive(true, animated: true)
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        coachingOverlayView.activatesAutomatically = false
        executeActions()
        isCoachingOverlayActive = false
        shouldShowCoachingOverlay = false
    }
    
}
