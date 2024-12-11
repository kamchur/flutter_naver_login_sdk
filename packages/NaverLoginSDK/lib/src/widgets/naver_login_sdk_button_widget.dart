import 'package:naver_login_sdk/src/widgets/naver_login_sdk_button_asset.dart';
import 'naver_login_sdk_button_style.dart';
import 'package:picture_button/picture_button.dart';
/// packages/naver_login_sdk/assets/btn_perfect_white.png
///
class NaverLoginButton extends PictureButton {
  NaverLoginButton({
    super.key,
    required super.onPressed,
    super.onLongPressed,
    super.onSelectChanged,
    required NaverButtonStyle style,
    super.imagePressed,
    super.imageSelected,
    super.width,
    super.height,
    super.fit,
    super.margin,
    super.opacity,
    super.border,
    super.borderRadius,
    super.borderRadiusInk,
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
    super.child
  }): super(
    image: NaverLoginButtonAsset(style: style),
  );
}
