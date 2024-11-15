import '/src/consts/naver_login_sdk_constant_oauth_login_callback.dart';
import '/src/events/naver_login_sdk_base_callback.dart';
import '/src/naver_login_sdk_typedef.dart';
import '/src/protocols/naver_login_sdk_oauth_login_callback_protocol.dart';

class OAuthLoginCallback extends NaverLoginSdkBaseCallback implements OAuthLoginCallbackProtocol {
  @override
  FunctionSuccess? onSuccess;

  @override
  FunctionFailure? onFailure;

  @override
  FunctionError? onError;

  OAuthLoginCallback({
    this.onSuccess,
    this.onFailure,
    this.onError
  }) {
    functionEvents[NaverLoginSdkConstantOAuthLoginCallback.onSuccess] = onSuccess;
    functionEvents[NaverLoginSdkConstantOAuthLoginCallback.onFailure] = onFailure;
    functionEvents[NaverLoginSdkConstantOAuthLoginCallback.onError] = onError;
  }
}