import '/src/consts/naver_login_sdk_constant_profile_callback.dart';
import '/src/events/naver_login_sdk_base_callback.dart';
import '/src/naver_login_sdk_typedef.dart';
import '/src/protocols/naver_login_sdk_profile_callback_protocol.dart';

class ProfileCallback extends NaverLoginSdkBaseCallback
    implements NaverLoginSdkProfileCallbackProtocol {
  @override
  FunctionError? onError;

  @override
  FunctionFailure? onFailure;

  @override
  FunctionProfileSuccess? onSuccess;

  ProfileCallback(
      {required this.onError,
      required this.onFailure,
      required this.onSuccess}) {
    // functionEvents.clear();

    functionEvents[NaverLoginSdkConstantProfileCallback.onError] = onError;
    functionEvents[NaverLoginSdkConstantProfileCallback.onFailure] = onFailure;
    functionEvents[NaverLoginSdkConstantProfileCallback.onSuccess] = onSuccess;
  }
}
