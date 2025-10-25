import 'package:naver_login_sdk/src/events/naver_login_sdk_oauth_logout_callback.dart';

import '../events/naver_login_sdk_callback.dart';

interface class NaverLoginSdkProtocol {
  Future<void> initialize(
          {String? urlScheme,
          required String clientId,
          required String clientSecret,
          String clientName = "Flutter NaverLogin"}) =>
      throw UnimplementedError('iniitialize() has not been implemented');

  Future<void> authenticate({OAuthLoginCallback? callback}) =>
      throw UnimplementedError('authenticate() has not been implemented');
  Future<void> refresh({OAuthLoginCallback? callback}) =>
      throw UnimplementedError('refresh() has not been implemented');
  Future<void> profile({required ProfileCallback callback}) =>
      throw UnimplementedError('profile() has not been implemented');
  Future<void> logout({OAuthLogoutCallback? callback}) =>
      throw UnimplementedError('logout() has not been implemented');
  Future<void> release({OAuthLoginCallback? callback}) =>
      throw UnimplementedError('release() has not been implemented');

  Future<String> getVersion() =>
      throw UnimplementedError('getVersion() has not been implemented');
  Future<String> getTokenType() =>
      throw UnimplementedError('getTokenType() has not been implemented');
  Future<dynamic> getExpireAt() =>
      throw UnimplementedError('getExpireAt() has not been implemented');
  Future<String> getAccessToken() =>
      throw UnimplementedError('getAccessToken() has not been implemented');
  Future<String> getRefreshToken() =>
      throw UnimplementedError('getRefreshToken() has not been implemented');
}
