import 'package:flutter/material.dart';

/// 2024-12-20-Fri,
/// I want to use [naverColor] anytime, anywhere.
///
/// [Naver Button Resource Guide](https://developers.naver.com/docs/login/bi/bi.md)
///
extension NaverLoginSDKColorExtension on ThemeData {
  /// NAVER GREEN
  /// This function used [HEX] type.
  ///
  /// HEX: #03C75A
  ///
  /// RGB: 3 / 199 / 90
  ///
  /// CMYK: 72 / 0 / 88 / 0
  ///
  /// PANTONE: 7479U
  ///
  Color get naverColor => const Color(0xFF03C75A);
}
