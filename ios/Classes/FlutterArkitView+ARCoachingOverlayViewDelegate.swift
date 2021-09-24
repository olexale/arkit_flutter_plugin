import Foundation
import ARKit

@available(iOS 13.0, *)
extension FlutterArkitView: ARCoachingOverlayViewDelegate {
  func addCoachingOverlay(_ arguments: Dictionary<String, Any>) {
    let goalType = arguments["goal"] as! Int
    let goal = ARCoachingOverlayView.Goal.init(rawValue: goalType)!
    
    let coachingView = ARCoachingOverlayView(frame: self.sceneView.frame)
    
    coachingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    removeCoachingOverlay()
    
    sceneView.addSubview(coachingView)
    
    coachingView.goal = goal
    coachingView.session = self.sceneView.session
    coachingView.delegate = self
    coachingView.setActive(true, animated: true)
  }
  
  func removeCoachingOverlay() {
    if let view = sceneView.subviews.first(where: {$0 is ARCoachingOverlayView}) {
      view.removeFromSuperview()
    }
  }
  
  func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
    self.channel.invokeMethod("coachingOverlayViewDidDeactivate", arguments: nil)
  }
}
