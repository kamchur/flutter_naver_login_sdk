package net.lagerstroemia.naver_login_sdk

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.navercorp.nid.NaverIdLoginSDK

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

// import net.lagerstroemia.naver_login_sdk.api.NaverLoginSdkConstant
// import net.lagerstroemia.naver_login_sdk.api.NaverLoginSdkBridge

/** NaverLoginSdkPlugin */
class NaverLoginSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var methodChannel : MethodChannel
  private lateinit var eventChannel: EventChannel
  // private lateinit var context: Context
  private var activity: Activity? = null

  private var sink: EventChannel.EventSink? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, NaverLoginSdkConstant.channelNameMethod)
    methodChannel.setMethodCallHandler(this)

    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, NaverLoginSdkConstant.channelNameEvent)
    eventChannel.setStreamHandler(this)
    // Use Other Activity
    // context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    activity?.let { otherActivity ->
      when (call.method) {
        NaverLoginSdkConstant.Key.initialize -> {
          NaverLoginSdkBridge.initialize(otherActivity, call.arguments)
          result.success(null)
        }
        NaverLoginSdkConstant.Key.authenticate -> {
            CoroutineScope(Dispatchers.Main).launch {
              NaverLoginSdkBridge.authenticate(otherActivity, sink = sink)
              result.success(null)
            }
        }
        NaverLoginSdkConstant.Key.logout -> {
          NaverLoginSdkBridge.logout()
          result.success(null)
        }
        NaverLoginSdkConstant.Key.release -> {
          CoroutineScope(Dispatchers.Main).launch {
            NaverLoginSdkBridge.release(sink = sink)
            result.success(null)
          }
        }
        NaverLoginSdkConstant.Key.profile -> {
          CoroutineScope(Dispatchers.Main).launch {
            NaverLoginSdkBridge.profile(sink = sink)
            result.success(null)
          }
        }
        NaverLoginSdkConstant.Key.refresh -> {
          CoroutineScope(Dispatchers.Main).launch {
            NaverLoginSdkBridge.refresh(sink = sink)
            result.success(null)
          }
        }
        NaverLoginSdkConstant.Key.version -> {
          result.success(NaverLoginSdkBridge.getVersion())
        }
        NaverLoginSdkConstant.Key.tokenType -> {
          result.success(NaverLoginSdkBridge.getTokenType())
        }
        NaverLoginSdkConstant.Key.expireAt -> {
          result.success(NaverLoginSdkBridge.getExpireAt())
        }
        NaverLoginSdkConstant.Key.accessToken -> {
          result.success(NaverLoginSdkBridge.getAccessToken())
        }
        NaverLoginSdkConstant.Key.refreshToken -> {
          result.success(NaverLoginSdkBridge.getRefreshToken())
        }
        else -> result.notImplemented()
      }
    } ?: result.error("No Activity", "Activity is not attached", null)
  }

  // EventChannel
  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    // Log.v("Crape", "NaverLoginSDK.. onListen..")
    sink = events
  }

  // EventChannel
  override fun onCancel(arguments: Any?) {
    // Log.v("Crape", "NaverLoginSDK.. onCancel..")
    sink = null
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }
}
