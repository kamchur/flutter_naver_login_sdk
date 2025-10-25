import '../consts/naver_login_sdk_constant_oauth_login_callback.dart';
import '../events/naver_login_sdk_base_callback.dart';
import '../naver_login_sdk_typedef.dart';
import '../protocols/naver_login_sdk_oauth_login_callback_protocol.dart';

class OAuthLoginCallback extends NaverLoginSdkBaseCallback
    implements OAuthLoginCallbackProtocol {
  /// onSuccess.. - LoginScreen > Click ID > OK(Agree)
  @override
  FunctionEmptySuccess? onSuccess;

  @override
  FunctionFailure? onFailure;

  /// onError.. errorCode:-1, message:user_cancel       - Nothing
  /// onError.. errorCode:-1, message:Canceled By User  - LoginScreen > Click ID > Cancel
  ///
  /// 2025-01-02-Thu,
  /// Naver APP not installed return -> errorCode:-1, message:naverapp_not_installed
  /// Naver App need update return -> errorCode:-1, message:naverapp_need_update
  ///
  @Deprecated("not use anymore")
  @override
  FunctionError? onError;

  OAuthLoginCallback({required this.onSuccess, this.onFailure, this.onError}) {
    // functionEvents.clear();

    functionEvents[NaverLoginSdkConstantOAuthLoginCallback.onSuccess] =
        onSuccess;
    functionEvents[NaverLoginSdkConstantOAuthLoginCallback.onFailure] =
        onFailure;
    functionEvents[NaverLoginSdkConstantOAuthLoginCallback.onError] = onError;
  }
}
