import 'package:flutter/material.dart';
import '../naver_login_sdk_controller.dart';
import 'package:picture_button/picture_button.dart';

import 'naver_login_sdk_button_asset.dart';
import 'naver_login_sdk_button_language.dart';
import 'naver_login_sdk_button_logout_style.dart';
import 'naver_login_sdk_button_mode.dart';

class NaverLogoutButton extends PictureButton {
  NaverLogoutButton(
      {super.key,
      required void Function(bool isLogout) onPressed,
      super.onLongPressed,
      super.onSelectChanged,
      NaverLogoutButtonStyle style = const NaverLogoutButtonStyle(
        language: NaverButtonLanguage.english,
        mode: NaverButtonMode.green
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
              final isLogout = await NaverLoginSDK.logout(isForced: true);
              onPressed(isLogout);
            },
            image: NaverLogoutButtonAsset(style: style),
            borderRadiusInk: borderRadiusInk ?? BorderRadius.circular(9.0));
}
