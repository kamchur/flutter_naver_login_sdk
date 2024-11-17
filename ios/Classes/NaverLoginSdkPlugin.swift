import Flutter
import UIKit

public class NaverLoginSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      // Register method channel
      let methodChannel = FlutterMethodChannel(name: NaverLoginSdkConstant.channelNameMethod, binaryMessenger: registrar.messenger())
      // Register event channel
      let eventChannel = FlutterEventChannel(name: NaverLoginSdkConstant.channelNameEvent, binaryMessenger: registrar.messenger())
      
      let instance = NaverLoginSdkPlugin()
      registrar.addMethodCallDelegate(instance, channel: methodChannel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case NaverLoginSdkConstant.Key.initialize:
        print("test...")
    // case "getPlatformVersion":
    //  result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
