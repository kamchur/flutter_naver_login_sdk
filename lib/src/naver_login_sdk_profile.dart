import 'dart:convert';

import '/src/consts/naver_login_sdk_constant_profile.dart';

/// for Android.
class NaverLoginProfile {
  final String? _id;
  final String? _nickName;
  final String? _name;
  final String? _email;
  final String? _gender;
  final String? _age;
  final String? _birthDay;
  final String? _profileImage;
  final String? _birthYear;
  final String? _mobile;
  final String? _ci;
  final String? _encId;

  NaverLoginProfile._(this._id, this._nickName, this._name, this._email, this._gender, this._age, this._birthDay, this._profileImage, this._birthYear, this._mobile, this._ci, this._encId);

  /// [response] : Android= NidProfile
  factory NaverLoginProfile.fromJson({required dynamic response}) {
      final json = jsonDecode(response);

      return NaverLoginProfile._(
          json[NaverLoginSdkConstantProfile.id],
          json[NaverLoginSdkConstantProfile.nickName],
          json[NaverLoginSdkConstantProfile.name],
          json[NaverLoginSdkConstantProfile.email],
          json[NaverLoginSdkConstantProfile.gender],
          json[NaverLoginSdkConstantProfile.age],
          json[NaverLoginSdkConstantProfile.birthDay],
          json[NaverLoginSdkConstantProfile.profileImage],
          json[NaverLoginSdkConstantProfile.birthYear],
          json[NaverLoginSdkConstantProfile.mobile],
          json[NaverLoginSdkConstantProfile.ci],
          json[NaverLoginSdkConstantProfile.encId],
      );
  }

  // Getter
  String? get id => _id;
  String? get nickName => _nickName;
  String? get name => _name;
  String? get email => _email;
  String? get gender => _gender;
  String? get age => _age;
  String? get birthDay => _birthDay;
  String? get profileImage => _profileImage;
  String? get birthYear => _birthYear;
  String? get mobile => _mobile;
  String? get ci => _ci;
  String? get encId => _encId;

  @override
  String toString() {
    return 'NaverLoginProfile('
        'id: $_id, '
        'nickName: $_nickName, '
        'name: $_name, '
        'email: $_email, '
        'gender: $_gender, '
        'age: $_age, '
        'birthDay: $_birthDay, '
        'profileImage: $_profileImage, '
        'birthYear: $_birthYear, '
        'mobile: $_mobile, '
        'ci: $_ci, '
        'encId: $_encId'
        ')';
  }
}