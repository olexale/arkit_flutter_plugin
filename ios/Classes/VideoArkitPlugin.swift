import ARKit
import Flutter

public class VideoArkitPlugin: NSObject, FlutterPlugin {
    static var nodes = [String: SKVideoNode]()
    static var players = [String: AVPlayer]()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "arkit_video_playback", binaryMessenger: registrar.messenger())
        let instance = VideoArkitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any],
              let id = arguments["id"] as? String
        else {
            result(nil)
            return
        }

        switch call.method {
        case "play":
            VideoArkitPlugin.players[id]?.play()
        case "pause":
            VideoArkitPlugin.players[id]?.pause()
        case "seek":
            VideoArkitPlugin.players[id]?.seek(to: CMTime(seconds: arguments["seconds"] as! Double, preferredTimescale: 600))
        case "dispose":
            VideoArkitPlugin.nodes.removeValue(forKey: id)
            VideoArkitPlugin.players.removeValue(forKey: id)
        default:
            break
        }
        result(nil)
    }
}
