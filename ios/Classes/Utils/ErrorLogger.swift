import Foundation

func logPluginError(_ message: String, toChannel channel: FlutterMethodChannel) {
  let methodName = Thread.callStackSymbols[1]
  DispatchQueue.main.async {
    channel.invokeMethod("onError", arguments: "\(methodName): \(message)")
  }
  
  debugPrint("\(methodName): \(message)")
}
