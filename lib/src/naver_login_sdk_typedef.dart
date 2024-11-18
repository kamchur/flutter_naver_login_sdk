
/// Manager Functinos
typedef FunctionEmptySuccess = Function();    // for onSuccess
typedef FunctionFailure = Function(int httpStatus, String message);   // for onFailure
typedef FunctionError = Function(int errorCode, String message);      // for onError
typedef FunctionProfileSuccess = Function(String resultCode, String message, dynamic response);   // for Profile onSuccess