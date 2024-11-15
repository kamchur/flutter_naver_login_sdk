

/// Manager Functinos
typedef FunctionSuccess = Function();
typedef FunctionFailure = Function(int httpStatus, String message);   // for onFailure
typedef FunctionError = Function(int errorCode, String message);      // for onError