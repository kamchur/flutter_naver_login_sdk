import 'dart:io';

import '/src/events/naver_login_sdk_callback.dart';
import 'naver_login_sdk_platform_interface.dart';

const String _requestInitializeMessage = 'Please execute NaverLoginSDK.initialize() function at first.';
const String _requestUrlSchemeMessage = 'iOS Platform required \'urlScheme\' parameter.';

/// Singleton
class NaverLoginSDK {
  NaverLoginSDK._internal();    // ._()

  static final NaverLoginSdkPlatform _instance = NaverLoginSdkPlatform.instance;

  static bool _isInitialize = false;

  /// [urlScheme] : iOS required parameter. </br>
  ///
  /// [clientId] : NaverApplication Center 'ClientId' </br>
  ///
  /// [clientSecret] : NaverApplication Center 'ClientSecret' </br>
  ///
  /// [clientName] : NaverApplication Center 'ClientName' </br>
  ///
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
    String? urlScheme,
    required String clientId,
    required String clientSecret,
    String clientName = "Flutter NaverLogin"
  }) {
    assert(Platform.isAndroid || (Platform.isIOS && urlScheme != null),
      _requestUrlSchemeMessage
    );
    _instance.initialize(
      urlScheme: urlScheme,
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

  static void refresh({OAuthLoginCallback? callback}) {
    assert(_isInitialize, _requestInitializeMessage);

    _instance.refresh(callback: callback);
  }

  static void logout() {
    assert(_isInitialize, _requestInitializeMessage);

    _instance.logout();
    // _isInitialize = false;
  }

  /// Break Off, remove token client and server.
  static void release({OAuthLoginCallback? callback}) {
    assert(_isInitialize, _requestInitializeMessage);

    _instance.release(callback: callback);
    // _isInitialize = false;
  }

  /// This function possible after execute [authenticate] function.
  ///
  /// If you don't have 'AccessToken' then will show you Exception Error message.
  /// ```dart
  /// NidProfileResponse(
  ///   resultCode=00,
  ///   message=success,
  ///   profile=NidProfile(id=yLstnezLnHh8qDr3PsgpsE6k8gxmqUQqIRCoDAmd8s4, nickname=null,
  ///     name=null, email=null, gender=null, age=null, birthday=null, profileImage=null,
  ///     birthYear=null, mobile=null, ci=null, encId=null)
  /// )
  /// ```
  static void profile({required ProfileCallback callback}) {
    assert(_isInitialize, _requestInitializeMessage);

    _instance.profile(callback: callback);
  }

  static Future<String> getVersion() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getVersion();
  }

  static Future<String> getTokenType() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getTokenType();
  }

  static Future<dynamic> getExpireAt() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getExpireAt();
  }

  static Future<String> getAccessToken() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getAccessToken();
  }

  static Future<String> getRefreshToken() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getRefreshToken();
  }
}