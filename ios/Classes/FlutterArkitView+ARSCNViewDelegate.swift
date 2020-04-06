import Foundation
import ARKit

extension FlutterArkitView: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        logPluginError("sessionDidFailWithError: \(error.localizedDescription)", toChannel: channel)
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera){
        var params = [String: NSString]()
        
        switch camera.trackingState {
        case .notAvailable:
            params["trackingState"] = "notAvailable" as NSString
        case .limited(let reason):
            // only if the tracking state is limited, a reason can be given
            params["trackingState"] = "limited" as NSString
            switch reason {
            case .excessiveMotion:
                params["reason"] = "excessiveMotion" as NSString
            case .insufficientFeatures:
                params["reason"] = "insufficientFeatures" as NSString
            case .initializing:
                params["reason"] = "initializing" as NSString
            case .relocalizing:
                params["reason"] = "relocalizing" as NSString
            default:
                print("Tracking quality is limited. Unexpected reason.")
            }
        case .normal:
            params["trackingState"] = "normal" as NSString
        default:
            print("Unexpected camera tracking state.")
        }
        
        self.channel.invokeMethod("onCameraDidChangeTrackingState", arguments: params)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        self.channel.invokeMethod("onSessionWasInterrupted", arguments: nil)
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        self.channel.invokeMethod("onSessionInterruptionEnded", arguments: nil)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if (node.name == nil) {
            node.name = NSUUID().uuidString
        }
        let params = prepareParamsForAnchorEvent(node, anchor)
        self.channel.invokeMethod("didAddNodeForAnchor", arguments: params)
    }
     
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        let params = prepareParamsForAnchorEvent(node, anchor)
        self.channel.invokeMethod("didUpdateNodeForAnchor", arguments: params)
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        let params = prepareParamsForAnchorEvent(node, anchor)
        self.channel.invokeMethod("didRemoveNodeForAnchor", arguments: params)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let params = ["time": NSNumber(floatLiteral: time)]
        self.channel.invokeMethod("updateAtTime", arguments: params)
    }
    
    fileprivate func prepareParamsForAnchorEvent(_ node: SCNNode, _ anchor: ARAnchor) -> Dictionary<String, Any> {
        var serializedAnchor = serializeAnchor(anchor)
        serializedAnchor["nodeName"] = node.name
        return serializedAnchor
    }
}
