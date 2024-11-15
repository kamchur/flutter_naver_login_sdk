import 'naver_login_sdk_platform_interface.dart';

/// Singleton
class NaverLoginSDK {
  NaverLoginSDK._();    // _internal()

  static Future<String?> getPlatformVersion() async {
    return NaverLoginSdkPlatform.instance.getPlatformVersion();
  }
}