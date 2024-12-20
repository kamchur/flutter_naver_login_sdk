import 'package:flutter/material.dart';
import 'package:picture_button/picture_button.dart';
import 'naver_login_sdk_button_logout_style.dart';
import 'naver_login_sdk_button_asset.dart';

class NaverLogoutButton extends PictureButton {
  NaverLogoutButton(
      {super.key,
      required super.onPressed,
      super.onLongPressed,
      super.onSelectChanged,
      required NaverLogoutButtonStyle style,
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
            image: NaverLogoutButtonAsset(style: style),
            borderRadiusInk: borderRadiusInk ?? BorderRadius.circular(9.0));
}
