import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'naver_login_sdk_button_style.dart';

const String btnKrRectangleWhite = 'packages/naver_login_sdk/assets/kr/bar/btn_kr_rectangle_white.png';

class NaverLoginButtonAsset extends ImageProvider<NaverLoginButtonAsset> {
  final NaverButtonStyle style;

  NaverLoginButtonAsset({
    required this.style,
  });


  @override
  Future<NaverLoginButtonAsset> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(NaverLoginButtonAsset key, ImageDecoderCallback decode) {
    assert(key == this);
    
    return OneFrameImageStreamCompleter(loadAssetImage);
  }
  
  Future<ImageInfo> get loadAssetImage async {
    try {
      final ByteData data = await rootBundle.load(btnKrRectangleWhite);
      final Codec codec = await instantiateImageCodec(data.buffer.asUint8List());
      final FrameInfo frame = await codec.getNextFrame();

      return ImageInfo(image: frame.image);
    } catch (e) {
      Log.e('Load Asset Image Exception:\n$e');
      throw Exception('Failed to load asset image:\n$e');
    }
  }
}