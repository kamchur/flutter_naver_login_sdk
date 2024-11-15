import 'package:naver_login_sdk/src/events/naver_login_sdk_callback.dart';

import 'naver_login_sdk_platform_interface.dart';

const String _requestInitializeMessage = 'Please execute NaverLoginSDK.initialize() function at first.';

/// Singleton
class NaverLoginSDK {
  NaverLoginSDK._internal();    // ._()

  static final NaverLoginSdkPlatform _instance = NaverLoginSdkPlatform.instance;

  static bool _isInitialize = false;

  /// #### Usage
  ///
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///
  ///   NaverLoginSDK.initialize([ClientId], [ClientSecret], [ClientName])
  ///   ...
  /// }
  /// ```
  ///
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
    assert(_isInitialize, _requestInitializeMessage);

    _instance.authenticate(callback: callback);
  }

  static void logout() {
    assert(_isInitialize, _requestInitializeMessage);

    _instance.logout();
  }

  static void release({OAuthLoginCallback? callback}) {
    assert(_isInitialize, _requestInitializeMessage);

    _instance.release(callback: callback);
  }
}