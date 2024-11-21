import Flutter
import UIKit
import NaverThirdPartyLogin

public class NaverLoginSdkPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, NaverThirdPartyLoginConnectionDelegate {
    var sink: FlutterEventSink?
    var naverConnection: NaverThirdPartyLoginConnection?        // instance for Delegate
    var lastCallMethod: String = ""     // for Receive Flag
    
    /// Register iOS Plugin Instance
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Register method channel
        let methodChannel = FlutterMethodChannel(name: NaverLoginSdkConstant.channelNameMethod, binaryMessenger: registrar.messenger())
        // Register event channel
        let eventChannel = FlutterEventChannel(name: NaverLoginSdkConstant.channelNameEvent, binaryMessenger: registrar.messenger())

        let instance = NaverLoginSdkPlugin()
        // Register EventChannel
        eventChannel.setStreamHandler(instance)

        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
    }
    
//    public func applicationWillEnterForeground(_ application: UIApplication) {
//        print("applicationWillEnterForeground..")
//    }
//    
//    public func applicationDidEnterBackground(_ application: UIApplication) {
//        print("applicationDidEnterBackground..")
//    }
    
    /// Connect Delegate
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // print("NaverLoginSdkPlugin.. open url:\(url)")
        
        if naverConnection != nil && url.absoluteString.contains(naverConnection!.serviceUrlScheme){
            return naverConnection!.application(application, open: url, options: options)
        } else {
            return true
        }
    }
    
    /// MethodChannel Handler
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.lastCallMethod = call.method
        
        switch self.lastCallMethod {
        case NaverLoginSdkConstant.Key.initialize:
            if let params = call.arguments as? [String: String] {
                // print("NaverLoginSdkPlugin handle.. params:\(params)")
                self.initialize(args: params)
            }
            
        case NaverLoginSdkConstant.Key.authenticate:
            self.authenticate()
            break
        // case "getPlatformVersion":
        //  result("iOS " + UIDevice.current.systemVersion)
        case NaverLoginSdkConstant.Key.logout:
            self.logout()
            break
        case NaverLoginSdkConstant.Key.release:
            self.release()
            break
        case NaverLoginSdkConstant.Key.profile:
            self.profile()
            break
        case NaverLoginSdkConstant.Key.refresh:
            self.refresh()
            break
        case NaverLoginSdkConstant.Key.version:
            result(self.getVersion())
            break
        case NaverLoginSdkConstant.Key.tokenType:
            result(self.getTokenType())
            break
        case NaverLoginSdkConstant.Key.expireAt:
            let seconds = if self.getExpireAt() != nil {
                Int(self.getExpireAt()!.timeIntervalSince1970)
            } else {
                0
            }
            result(seconds)
            break
        case NaverLoginSdkConstant.Key.acessToken:
            result(self.getAccessToken())
            break
        case NaverLoginSdkConstant.Key.refreshToken:
            result(self.getRefreshToken())
            break
        default:
          result(FlutterMethodNotImplemented)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.sink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.lastCallMethod = ""
        self.sink = nil
        return nil
    }
}
