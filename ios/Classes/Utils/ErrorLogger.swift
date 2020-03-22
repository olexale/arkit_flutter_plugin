import Foundation

func logPluginError(_ message: String, toChannel channel: FlutterMethodChannel) {
    channel.invokeMethod("onError", arguments: message)
}
