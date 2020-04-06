import Foundation
import ARKit

extension FlutterArkitView: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        logPluginError("sessionDidFailWithError: \(error.localizedDescription)", toChannel: channel)
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
