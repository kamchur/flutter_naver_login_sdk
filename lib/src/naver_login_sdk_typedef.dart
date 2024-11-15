

/// Manager Functinos
typedef FunctionSuccess = Function();
typedef FunctionFailure = Function(int httpStatus, String message);
typedef FunctionError = Function(int errorCode, String message);