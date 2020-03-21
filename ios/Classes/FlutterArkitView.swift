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
            self.initalize(call, result)
            break
        default:
            break
        }
    }
    
}

extension FlutterArkitView: ARSCNViewDelegate {
    
}
