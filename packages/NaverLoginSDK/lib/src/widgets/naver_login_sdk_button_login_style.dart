import 'naver_login_sdk_button_type.dart';
import 'naver_login_sdk_button_mode.dart';
import 'naver_login_sdk_button_language.dart';

/// 2024-12-12-Thu
/// For [NaverLoginButton]
///
/// [language] - default, 'korean'
///
/// [mode] - NaverButton color: green, dark, white
///
/// [type] - NaverButton shape
///
class NaverLoginButtonStyle {
  final NaverButtonLanguage language;
  final NaverButtonMode mode;
  final NaverButtonType type;

  NaverLoginButtonStyle({
    this.language = NaverButtonLanguage.korean,
    required this.mode,
    required this.type,
  });
}
