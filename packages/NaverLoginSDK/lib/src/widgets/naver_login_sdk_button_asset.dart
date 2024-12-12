import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'naver_login_sdk_button_language.dart';
import 'naver_login_sdk_button_login_style.dart';
import 'naver_login_sdk_button_logout_style.dart';
import 'naver_login_sdk_button_mode.dart';
import 'naver_login_sdk_button_type.dart';

// const String btnKrRectangleWhite = 'packages/naver_login_sdk/assets/kr/bar/btn_kr_rectangle_white.png';

class NaverLoginButtonAsset extends ImageProvider<NaverLoginButtonAsset> {
  final NaverLoginButtonStyle style;

  NaverLoginButtonAsset({
    required this.style,
  });

  @override
  Future<NaverLoginButtonAsset> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(
      NaverLoginButtonAsset key, ImageDecoderCallback decode) {
    assert(key == this);

    return OneFrameImageStreamCompleter(loadAssetImage);
  }

  Future<ImageInfo> get loadAssetImage async {
    final StringBuffer assetBuffer =
        StringBuffer('packages/naver_login_sdk/assets/');

    // Check Language
    if (style.language == NaverButtonLanguage.korean) {
      assetBuffer.write('kr/');
    } else {
      // The others English.
      assetBuffer.write('en/');
    }

    // Check Mode(Color)
    switch (style.mode) {
      case NaverButtonMode.green:
        assetBuffer.write('green/');
      case NaverButtonMode.white:
        assetBuffer.write('white/');
      case NaverButtonMode.dark:
        assetBuffer.write('dark/');
    }

    switch (style.type) {
      case NaverButtonType.rectangleBar:
        assetBuffer.write('btn_rectangle.png');
      case NaverButtonType.rectangleWithNaverBar:
        assetBuffer.write('btn_rectangle_with_naver.png');
      case NaverButtonType.circleIcon:
        assetBuffer.write('btn_circle_icon.png');
      case NaverButtonType.rectangleIcon:
        assetBuffer.write('btn_rectangle_icon.png');
    }

    try {
      final ByteData data = await rootBundle.load(assetBuffer.toString());
      final Codec codec =
          await instantiateImageCodec(data.buffer.asUint8List());
      final FrameInfo frame = await codec.getNextFrame();

      return ImageInfo(image: frame.image);
    } catch (e) {
      Log.e('Load Asset Image Exception:\n$e');
      throw Exception('Failed to load asset image:\n$e');
    }
  }
}

class NaverLogoutButtonAsset extends ImageProvider<NaverLogoutButtonAsset> {
  final NaverLogoutButtonStyle style;

  NaverLogoutButtonAsset({
    required this.style,
  });

  @override
  Future<NaverLogoutButtonAsset> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(
      NaverLogoutButtonAsset key, ImageDecoderCallback decode) {
    assert(key == this);

    return OneFrameImageStreamCompleter(loadAssetImage);
  }

  Future<ImageInfo> get loadAssetImage async {
    final StringBuffer assetBuffer =
        StringBuffer('packages/naver_login_sdk/assets/');

    // Check Language
    if (style.language == NaverButtonLanguage.korean) {
      assetBuffer.write('kr/logout/');
    } else {
      // The others English.
      assetBuffer.write('en/logout/');
    }

    // Check Mode(Color)
    switch (style.mode) {
      case NaverButtonMode.green:
        assetBuffer.write('btn_logout_green.png');
      case NaverButtonMode.white:
        assetBuffer.write('btn_logout_white.png');
      case NaverButtonMode.dark:
        assetBuffer.write('btn_logout_dark.png');
    }

    try {
      final ByteData data = await rootBundle.load(assetBuffer.toString());
      final Codec codec =
          await instantiateImageCodec(data.buffer.asUint8List());
      final FrameInfo frame = await codec.getNextFrame();

      return ImageInfo(image: frame.image);
    } catch (e) {
      Log.e('Load Asset Image Exception:\n$e');
      throw Exception('Failed to load asset image:\n$e');
    }
  }
}
