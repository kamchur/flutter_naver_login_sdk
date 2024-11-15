import 'package:naver_login_sdk/src/events/naver_login_sdk_callback.dart';

import 'naver_login_sdk_platform_interface.dart';

/// Singleton
class NaverLoginSDK {
  NaverLoginSDK._internal();    // ._()

  static final NaverLoginSdkPlatform _instance = NaverLoginSdkPlatform.instance;

  static bool _isInitialize = false;

  static void initialize({
    required String clientId,
    required String clientSecret,
    String clientName = "Flutter NaverLogin"
  }) {
    _instance.initialize(
      clientId: clientId,
      clientSecret: clientSecret,
      clientName: clientName
    );

    _isInitialize = true;
  }

  static void authenticate({OAuthLoginCallback? callback}) {
    assert(_isInitialize, "Please execute NaverLoginSDK.initialize() function at first.");

    _instance.authenticate(callback: callback);
  }
}