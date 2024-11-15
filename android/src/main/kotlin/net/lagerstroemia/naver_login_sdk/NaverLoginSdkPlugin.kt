package net.lagerstroemia.naver_login_sdk

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

// import net.lagerstroemia.naver_login_sdk.api.NaverLoginSdkConstant
// import net.lagerstroemia.naver_login_sdk.api.NaverLoginSdkBridge

/** NaverLoginSdkPlugin */
class NaverLoginSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  // private lateinit var context: Context
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, NaverLoginSdkConstant.channelName)
    channel.setMethodCallHandler(this)

    // Use Other Activity
    // context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    activity?.let { otherActivity ->
      when (call.method) {
        NaverLoginSdkConstant.Key.initialize -> NaverLoginSdkBridge.initialize(otherActivity, call.arguments)
        NaverLoginSdkConstant.Key.authenticate -> {
            CoroutineScope(Dispatchers.Main).launch {
              NaverLoginSdkBridge.authenticate(otherActivity)
            }
        }
        else -> result.notImplemented()
      }
    } ?: result.error("No Activity", "Activity is not attached", null)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
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
