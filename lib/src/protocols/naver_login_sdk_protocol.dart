import '/src/events/naver_login_sdk_callback.dart';

interface class NaverLoginSdkProtocol {
  void initialize({
    required String clientId,
    required String clientSecret,
    String clientName = "Flutter NaverLogin"
  }) => throw UnimplementedError('iniitialize() has not been implemented');

  void authenticate({OAuthLoginCallback? callback}) => throw UnimplementedError('authenticate() has not been implemented');
}