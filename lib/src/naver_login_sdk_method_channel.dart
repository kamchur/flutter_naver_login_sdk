import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:naver_login_sdk/src/naver_login_sdk_constant.dart';

import 'naver_login_sdk_platform_interface.dart';

/// An implementation of [NaverLoginSdkPlatform] that uses method channels.
class NaverLoginSdkMethodChannel extends NaverLoginSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('naver_login_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = ""; //await methodChannel.invokeMethod<String>(NaverLoginSdkConstant.platformVersion);
    return version;
  }
}
