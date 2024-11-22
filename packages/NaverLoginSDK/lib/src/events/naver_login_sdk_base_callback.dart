abstract class NaverLoginSdkBaseCallback {
  /// Managing Functions.
  Map<String, Function?> functionEvents = {};

  /// Connection to EventChannel StreambroadcastrReceiver
  ///
  /// I/flutter (13565): listen.. event:{onError: {errorCode: -1, message: user_cancel}}
  void listen<T>(T event) async {
    if (event is Map) {
      try {
        // Check 'key' only one
        // Check 'value' only one
        final String key = event.keys.first;
        final dynamic arguments = event.values.first;

        Function? functionEvent = functionEvents[key];

        if (functionEvent != null) {
          Function.apply(functionEvent, arguments);
        }
      } catch (e, stackTrace) {
        // Log.w("\n$stackTrace");
      }
    }
  }
}
