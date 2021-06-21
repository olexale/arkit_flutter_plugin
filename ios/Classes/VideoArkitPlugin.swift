import Flutter
import ARKit

public class VideoArkitPlugin: NSObject, FlutterPlugin {
  static var nodes = [String: SKVideoNode]()
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "arkit_video_playback", binaryMessenger: registrar.messenger())
    let instance = VideoArkitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let arguments = call.arguments as? Dictionary<String, Any>,
       let id = arguments["id"] as? String else {
      result(nil)
      return
    }
    
    switch call.method {
    case "play":
      VideoArkitPlugin.nodes[id]?.play()
      break
    case "pause":
      VideoArkitPlugin.nodes[id]?.pause()
      break
    case "dispose":
      VideoArkitPlugin.nodes.removeValue(forKey: id)
      break
    default:
      break
    }
    result(nil)
  }
}
