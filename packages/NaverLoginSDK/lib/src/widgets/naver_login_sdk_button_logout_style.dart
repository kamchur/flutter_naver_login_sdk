import 'naver_login_sdk_button_language.dart';
import 'naver_login_sdk_button_mode.dart';

/// 2024-12-12-Thu
/// For [NaverLogoutButton]
///
/// [language] - default, 'korean'
///
/// [mode] - NaverButton color: green, dark, white
///
class NaverLogoutButtonStyle {
  final NaverButtonLanguage language;
  final NaverButtonMode mode;

  /// [NaverLogoutButtonStyle] has only type RectangleBar
  ///
  NaverLogoutButtonStyle({
    this.language = NaverButtonLanguage.korean,
    required this.mode,
  });
}
