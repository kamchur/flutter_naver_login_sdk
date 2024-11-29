import 'dart:io';

import 'package:naver_login_sdk/naver_login_sdk.dart';

import 'naver_login_sdk_platform_interface.dart';

const String _requestInitializeMessage =
    'Please execute NaverLoginSDK.initialize() function at first.';
const String _requestUrlSchemeMessage =
    'iOS Platform required \'urlScheme\' parameter.';

/// Singleton
///
/// e-mail: b3xlon9@gmail.com(or naver.com)
/// Call me whenever Naver Team:)
///
/// I am ready to go there.
///
///
/// The reason I created the Flutter-'NaverLoginSDK' is to make it
/// convenient for Flutter users in Korea.
/// Moreover, since Flutter is an excellent platform used worldwide,
/// I’m confident that using Naver Login will help raise Korea's recognition globally:)
///
/// Thanks!
class NaverLoginSDK {
  NaverLoginSDK._internal(); // ._()

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
  static Future<void> initialize(
      {String? urlScheme,
      required String clientId,
      required String clientSecret,
      String clientName = "Flutter NaverLogin"}) async {
    assert(Platform.isAndroid || (Platform.isIOS && urlScheme != null),
        _requestUrlSchemeMessage);
    await _instance.initialize(
        urlScheme: urlScheme,
        clientId: clientId,
        clientSecret: clientSecret,
        clientName: clientName);

    _isInitialize = true;
  }

  /// Request 'Login'
  ///
  /// Open NaverInApp and check your account.
  ///
  /// -
  ///
  /// Required execute after [initialize] function.
  static Future<void> authenticate({OAuthLoginCallback? callback}) async {
    assert(_isInitialize, _requestInitializeMessage);

    await _instance.authenticate(callback: callback);
  }

  /// Refresh your accessToken
  ///
  /// expireAt default 3600(s).
  static Future<void> refresh({OAuthLoginCallback? callback}) async {
    assert(_isInitialize, _requestInitializeMessage);

    await _instance.refresh(callback: callback);
  }

  /// Logout your local account.
  ///
  /// If you want more clear access that you have to use [release] function.
  static Future<void> logout() async {
    assert(_isInitialize, _requestInitializeMessage);

    await _instance.logout();
    // _isInitialize = false;
  }

  /// Break Off, remove token client and server.
  static Future<void> release({OAuthLoginCallback? callback}) async {
    assert(_isInitialize, _requestInitializeMessage);

    await _instance.release(callback: callback);
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
  ///
  /// And If you want Profile data model class, I supplied [NaverLoginProfile] class.
  /// Use [NaverLoginProfile.fromJson(response: response)] code.
  ///
  /// It will be auto converting.
  ///
  /// ## Usage
  /// ```dart
  ///  NaverLoginSDK.profile(callback: ProfileCallback(
  ///   onError: (errorCode, message) {
  ///     Log.e("onError.. message:$message");
  ///   },
  ///   onFailure: (httpStatus, message) {
  ///     Log.w("onFailure.. httpsStatus:$httpStatus, message:$message");
  ///   },
  ///   onSuccess: (resultCode, message, response) {
  ///     Log.i("onSuccess.. resultCode:$resultCode, message:$message, profile:$response");
  ///     final profile = NaverLoginProfile.fromJson(response: response);
  ///     Log.i("profile:$profile");
  ///   },
  /// ```
  ///
  /// -
  ///
  /// If you used [profile] function in [authenticate] function's [onSuccess] parameter.
  /// You should define delay([Duration]) before [profile] function.
  ///
  /// ```dart
  /// NaverLoginSDK.authenticate(callback: OAuthLoginCallback(
  ///    onSuccess: () {
  ///       Future.delayed(Duration(seconds:1), () {
  ///         NaverLoginSDK.profile(callback: ProfileCallback(
  ///           ...
  ///         ));
  ///       })
  ///     },)
  ///     ...
  ///     ..
  /// ```
  static Future<void> profile({required ProfileCallback callback}) async {
    assert(_isInitialize, _requestInitializeMessage);

    await _instance.profile(callback: callback);
  }

  /// Library Version
  ///
  /// iOS, Android have different version.
  static Future<String> getVersion() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getVersion();
  }

  /// Token Type information
  static Future<String> getTokenType() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getTokenType();
  }

  /// Expire Time Seconds.
  ///
  /// Android - Long
  /// iOS - Int
  static Future<dynamic> getExpireAt() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getExpireAt();
  }

  /// Current AccessToken Information
  static Future<String> getAccessToken() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getAccessToken();
  }

  /// Current RefreshToken Information
  static Future<String> getRefreshToken() async {
    assert(_isInitialize, _requestInitializeMessage);

    return await _instance.getRefreshToken();
  }

  /// 2024-11-29-Fri, Login Check
  ///
  /// First, Checked AccessToken and text state.
  static Future<bool> get isLogin async {
    return (await getAccessToken()).isNotEmpty;
  }
}
