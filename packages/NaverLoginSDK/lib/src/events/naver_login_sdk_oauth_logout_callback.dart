import '../events/naver_login_sdk_oauth_login_callback.dart';

class OAuthLogoutCallback extends OAuthLoginCallback {
  OAuthLogoutCallback({
    required super.onSuccess,
    super.onFailure,
    @Deprecated("not use anymore, only use onFailure") super.onError
  });
}
