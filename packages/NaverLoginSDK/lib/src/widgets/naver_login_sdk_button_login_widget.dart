import 'package:flutter/material.dart';

import 'naver_login_sdk_button_asset.dart';
import 'naver_login_sdk_button_login_style.dart';
import 'package:picture_button/picture_button.dart';

/// 2024-12-12-Thu
///
/// [PictureButton] v0.1.1
///
/// [PictureButton](https://pub.dev/packages/picture_button)
///
class NaverLoginButton extends PictureButton {
  /// required [NaverLoginButtonStyle]
  ///
  /// Language was both [Korean] and [English].
  /// If you want change there. Changed [NaverButtonLanguage].
  NaverLoginButton(
      {super.key,
      required super.onPressed,
      super.onLongPressed,
      super.onSelectChanged,
      required NaverLoginButtonStyle style,
      super.imagePressed,
      super.imageSelected,
      super.width,
      super.height,
      super.fit,
      super.margin,
      super.opacity,
      super.border,
      super.borderRadius,
      BorderRadius? borderRadiusInk,
      super.paddingInk,
      super.backgroundColor,
      super.splashColor,
      super.highlightColor,
      super.focusColor,
      super.hoverColor,
      super.enabled,
      super.vibrate,
      super.useBubbleEffect,
      super.bubbleEffect,
      super.child})
      : super(
          image: NaverLoginButtonAsset(style: style),
          borderRadiusInk: borderRadiusInk ?? BorderRadius.circular(9.0)
        );
}
