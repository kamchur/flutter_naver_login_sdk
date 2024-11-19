import Flutter
import UIKit
import NaverThirdPartyLogin

public class NaverLoginSdkPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    var sink: FlutterEventSink?
    
    /// Register iOS Plugin Instance
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Register method channel
        let methodChannel = FlutterMethodChannel(name: NaverLoginSdkConstant.channelNameMethod, binaryMessenger: registrar.messenger())
        // Register event channel
        let eventChannel = FlutterEventChannel(name: NaverLoginSdkConstant.channelNameEvent, binaryMessenger: registrar.messenger())

        let instance = NaverLoginSdkPlugin()
        // Register EventChannel
        eventChannel.setStreamHandler(instance)

        registrar.addMethodCallDelegate(instance, channel: methodChannel)
    }

    /// MethodChannel Handler
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case NaverLoginSdkConstant.Key.initialize:
            if let params = call.arguments as? [String: String] {
                print("params:\(params)")
                self.initialize(args: params)
            }
            
        case NaverLoginSdkConstant.Key.authenticate:
            self.authenticate()
        // case "getPlatformVersion":
        //  result("iOS " + UIDevice.current.systemVersion)
        case NaverLoginSdkConstant.Key.logout:
            self.logout()
        case NaverLoginSdkConstant.Key.profile:
            self.profile()
        default:
          result(FlutterMethodNotImplemented)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.sink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.sink = nil
        return nil
    }
}
