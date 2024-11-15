import 'naver_login_sdk_platform_interface.dart';

/// Singleton
class NaverLoginSDK {
  NaverLoginSDK._internal();    // ._()

  static final NaverLoginSdkPlatform _instance = NaverLoginSdkPlatform.instance;

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
  }

  static void authenticate() {
    _instance.authenticate();
  }
}