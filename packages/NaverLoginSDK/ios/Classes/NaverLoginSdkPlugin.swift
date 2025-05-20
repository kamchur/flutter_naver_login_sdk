import Flutter
import UIKit
import NaverThirdPartyLogin

public class NaverLoginSdkPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, NaverThirdPartyLoginConnectionDelegate {
    var sink: FlutterEventSink?
    var naverConnection: NaverThirdPartyLoginConnection?        // instance for Delegate
    var lastCallMethod: String = ""     // for Receive Flag
    var flutterResult: FlutterResult?   // 2025-05-16-Fri, iOS set Asynchronous return
    
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
   
        if naverConnection != nil && (url.scheme == naverConnection!.serviceUrlScheme) {
            return naverConnection!.application(application, open: url, options: options)
        } else {
            return false
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
                result(nil)
            }
            
        case NaverLoginSdkConstant.Key.authenticate:
            DispatchQueue.main.async {
                self.flutterResult = result
                
                self.authenticate()
                // result(nil)
            }
            break
        // case "getPlatformVersion":
        //  result("iOS " + UIDevice.current.systemVersion)
        case NaverLoginSdkConstant.Key.logout:
            DispatchQueue.main.async {
                self.logout()
                result(nil)
            }
            break
        case NaverLoginSdkConstant.Key.release:
            DispatchQueue.main.async {
                self.flutterResult = result
                
                self.release()
                // result(nil)
            }
            break
        case NaverLoginSdkConstant.Key.profile:
            DispatchQueue.main.async {
                self.flutterResult = result
                
                self.profile()
                // result(nil)
            }
            break
        case NaverLoginSdkConstant.Key.refresh:
            DispatchQueue.main.async {
                self.flutterResult = result
                
                self.refresh()
                // result(nil)         // Future<void>
            }
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
        self.flutterResult = nil
        return nil
    }
}
