import '../naver_login_sdk_typedef.dart';

interface class NaverLoginSdkProfileCallbackProtocol {
  FunctionProfileSuccess? onSuccess = throw UnimplementedError('onSuccess() has not been implemented');
  /// onFailure parameters
  /// (httpStatus: Int, message: String)
  FunctionFailure? onFailure = throw UnimplementedError('onFailure() has not been implemented');
  /// onError parameters
  /// (errorCode: Int, message: String)
  FunctionError? onError = throw UnimplementedError('onError() has not been implemented');
}