/// Manager Functions
typedef FunctionEmptySuccess = Function(); // for onSuccess
/// 2025-10-25-Sat
/// replace httpStatus type int -> String
typedef FunctionFailure = Function(
    String httpStatus, String message); // for onFailure
typedef FunctionError = Function(int errorCode, String message); // for onError
typedef FunctionProfileSuccess = Function(String resultCode, String message,
    dynamic response); // for Profile onSuccess
