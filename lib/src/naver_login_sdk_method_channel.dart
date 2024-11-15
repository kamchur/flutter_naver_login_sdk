import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:naver_login_sdk/src/naver_login_sdk_constant.dart';

import 'naver_login_sdk_platform_interface.dart';

/// An implementation of [NaverLoginSdkPlatform] that uses method channels.
class NaverLoginSdkMethodChannel extends NaverLoginSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(NaverLoginSdkConstant.channelName);

  // @override
  // Future<String?> getPlatformVersion() async {
  //   final version = ""; //await methodChannel.invokeMethod<String>(NaverLoginSdkConstant.platformVersion);
  //   return version;
  // }

  @override
  void initialize({required String clientId, required String clientSecret, String clientName = "Flutter NaverLogin"}) async {
    final Map<String, String> params = {
      NaverLoginSdkConstant.value.initialize.clientId: clientId,
      NaverLoginSdkConstant.value.initialize.clientSecret: clientSecret,
      NaverLoginSdkConstant.value.initialize.clientName: clientName
    };
    await methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.initialize, params);
  }

  @override
  void authenticate() async {
    await methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.authenticate);
  }
}
