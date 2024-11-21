import '/src/protocols/naver_login_sdk_protocol.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'naver_login_sdk_channel.dart';

abstract class NaverLoginSdkPlatform extends PlatformInterface
    implements NaverLoginSdkProtocol {
  /// Constructs a NaverLoginSdkPlatform.
  NaverLoginSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static NaverLoginSdkPlatform _instance = NaverLoginSdkChannel();

  /// The default instance of [NaverLoginSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelNaverLoginSdk].
  static NaverLoginSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NaverLoginSdkPlatform] when
  /// they register themselves.
  static set instance(NaverLoginSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // 2024-11-15-Fri, Sample test function
  // Future<String?> getPlatformVersion() {
  //   throw UnimplementedError('platformVersion() has not been implemented.');
  // }
}
