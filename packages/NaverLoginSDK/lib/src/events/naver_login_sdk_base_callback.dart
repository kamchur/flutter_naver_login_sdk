import 'package:flutter_logcat/flutter_logcat.dart';

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
        final dynamic arguments =
            _convertArguments(arguments: event.values.first);

        final Function? functionEvent = functionEvents[key];

        if (functionEvent != null &&
            (_paramsCount(function: functionEvent.runtimeType.toString()) ==
                _argumentsCount(arguments: arguments))) {
          Function.apply(functionEvent, arguments);
        }
      } catch (e, stackTrace) {
        Log.w("\n$stackTrace");
      }
    }
  }

  /// 2025-01-03-Fri, resolved for Closure Problem.
  /// Matching arugments count.
  ///
  /// ```dart
  /// function.runtimeType;
  /// ```
  ///
  /// - result
  /// ```text
  ///   () => Null
  ///   (String, String, dynamic) => Null
  /// ```
  ///
  int _paramsCount({required String function}) {
    final startBracketIndex = function.indexOf(
      '(',
    );
    final endBracketIndex = function.lastIndexOf(') =>');
    final String subFunction = function
        .substring(startBracketIndex + 1, endBracketIndex)
        .replaceAll(' ', '');
    final List<String> params = subFunction.split(',');

    /* If values return Map type. you should use this.
    params.removeWhere((element) => element.startsWith('Map'),);
    */

    return subFunction.isNotEmpty ? params.length : 0;
  }

  /// For matching [_paramsCount].
  ///
  /// check Null count.
  int _argumentsCount({required dynamic arguments}) {
    // List<dynamic> == List<Object?>
    if (arguments is List<dynamic>) {
      return arguments.length;
    } else if (arguments == null) {
      return 0;
    } else {
      return 1;
    }
  }

  /// Function arguments need List type.
  ///
  /// This problem is when parameter has only one or null.
  /// so convert function return List type or null.
  ///
  dynamic _convertArguments({required dynamic arguments}) =>
      arguments != null && arguments is! List ? [arguments] : arguments;
}
