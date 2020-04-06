import Flutter
import UIKit
import ARKit

public class SwiftArkitPlugin: NSObject, FlutterPlugin {
    public static var registrar:FlutterPluginRegistrar? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        SwiftArkitPlugin.registrar = registrar
        let arkitFactory = FlutterArkitFactory(messenger: registrar.messenger())
        registrar.register(arkitFactory, withId: "arkit")
        
        let channel = FlutterMethodChannel(name: "arkit_configuration", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(SwiftArkitPlugin(), channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "checkConfiguration") {
            let res = checkConfiguration(call.arguments)
            result(res)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    
}

class FlutterArkitFactory :NSObject, FlutterPlatformViewFactory {
    let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let view = FlutterArkitView(withFrame: frame, viewIdentifier: viewId, messenger: self.messenger)
        return view
    }
}
