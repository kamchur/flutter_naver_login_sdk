import 'package:flutter/material.dart';
import '../naver_login_sdk_controller.dart';
import '../naver_login_sdk_profile.dart';

import 'naver_login_sdk_button_asset.dart';
import 'naver_login_sdk_button_login_style.dart';
import 'naver_login_sdk_button_language.dart';
import 'naver_login_sdk_button_mode.dart';
import 'naver_login_sdk_button_type.dart';
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
      required void Function(NaverLoginProfile? userProfile) onPressed,
      super.onLongPressed,
      super.onSelectChanged,
      NaverLoginButtonStyle style = const NaverLoginButtonStyle(
          language: NaverButtonLanguage.english,
          mode: NaverButtonMode.green,
          type: NaverButtonType.rectangleBar
      ),
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
      super.splashColor = Colors.transparent,
      super.highlightColor = Colors.transparent,
      super.focusColor,
      super.hoverColor,
      super.enabled,
      super.vibrate,
      super.useBubbleEffect = true,
      super.bubbleEffect,
      super.child})
      : super(
            onPressed: () async {
              final bool isLogin = await NaverLoginSDK.login();

              if (isLogin) {
                final userProfile = await NaverLoginSDK.profile();
                onPressed(userProfile);
              } else {
                onPressed(null);
              }
            },
            image: NaverLoginButtonAsset(style: style),
            borderRadiusInk: borderRadiusInk ?? BorderRadius.circular(9.0));
}
