import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_logcat/flutter_logcat.dart';

import 'events/naver_login_sdk_callback.dart';
import 'naver_login_sdk_constant.dart';
import 'naver_login_sdk_platform_interface.dart';

/// An implementation of [NaverLoginSdkPlatform] that uses method channels.
class NaverLoginSdkChannel extends NaverLoginSdkPlatform {
  /// Not final initialize
  OAuthLoginCallback? oauthLoginCallback;
  ProfileCallback? profileCallback;

  /// The method channel used to interact with the native platform.
  // @visibleForTesting
  final MethodChannel _methodChannel = const MethodChannel(NaverLoginSdkConstant.channelNameMethod);
  final EventChannel _eventChannel = const EventChannel(NaverLoginSdkConstant.channelNameEvent);

  /// Constructor
  NaverLoginSdkChannel() {
    _eventChannel.receiveBroadcastStream().listen(_onData);
  }

  // @override
  // Future<String?> getPlatformVersion() async {
  //   final version = ""; //await methodChannel.invokeMethod<String>(NaverLoginSdkConstant.platformVersion);
  //   return version;
  // }
  /// Neck Through
  void _onData<T>(T event) async {
    oauthLoginCallback?.listen(event);
    profileCallback?.listen(event);
  }


  @override
  void initialize({String? urlScheme, required String clientId, required String clientSecret, String clientName = "Flutter NaverLogin"}) async {
    Log.v("initialize..");
    final Map<String, String> params = {
      if (Platform.isIOS && urlScheme != null) NaverLoginSdkConstant.value.initialize.urlScheme: urlScheme,
      NaverLoginSdkConstant.value.initialize.clientId: clientId,
      NaverLoginSdkConstant.value.initialize.clientSecret: clientSecret,
      NaverLoginSdkConstant.value.initialize.clientName: clientName
    };
    await _methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.initialize, params);
  }

  @override
  void authenticate({OAuthLoginCallback? callback}) async {
    oauthLoginCallback = callback;
    profileCallback = null;

    await _methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.authenticate);
  }

  @override
  void refresh({OAuthLoginCallback? callback}) async {
    oauthLoginCallback = callback;
    profileCallback = null;

    await _methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.refresh);
  }

  @override
  void profile({required ProfileCallback callback}) async {
    profileCallback = callback;
    oauthLoginCallback = null;

    await _methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.profile);
  }

  @override
  void logout() async {
    oauthLoginCallback = null;
    profileCallback = null;

    await _methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.logout);
  }

  /// [release] function click continue.
  ///
  /// Android -> onFailure.. httpStatus:200, message:OK
  /// iOS -> onError.. errorCode:1, message:PARAMETERNOTSET
  @override
  void release({OAuthLoginCallback? callback}) async {
    oauthLoginCallback = callback;
    profileCallback = null;

    await _methodChannel.invokeMethod<Void>(NaverLoginSdkConstant.key.release);
  }

  @override
  Future<String> getVersion() async {
    return await _methodChannel.invokeMethod<String>(NaverLoginSdkConstant.key.version) ?? "0";
  }


  @override
  Future<String> getTokenType() async {
    return await _methodChannel.invokeMethod<String>(NaverLoginSdkConstant.key.tokenType) ?? "";
  }

  @override
  Future<dynamic> getExpireAt() async {
    return await _methodChannel.invokeMethod(NaverLoginSdkConstant.key.expireAt);
  }

  @override
  Future<String> getAccessToken() async {
    // throw UnimplementedError();
    return await _methodChannel.invokeMethod<String>(NaverLoginSdkConstant.key.accessToken) ?? "";
  }

  @override
  Future<String> getRefreshToken() async {
    return await _methodChannel.invokeMethod<String>(NaverLoginSdkConstant.key.refreshToken) ?? "";
  }
}
