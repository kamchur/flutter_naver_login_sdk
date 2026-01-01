import 'dart:convert';

import '/src/consts/naver_login_sdk_constant_profile.dart';

/// User Profile
///
/// Maybe you will come here to get [id].
///
class NaverLoginProfile {
  String? _id;
  String? _nickName;
  String? _name;
  String? _email;
  String? _gender;
  String? _age;
  String? _birthDay;
  String? _profileImage;
  String? _birthYear;
  String? _mobile;
  String? _ci;
  String? _encId;

  NaverLoginProfile._(
      {String? id,
      String? nickName,
      String? name,
      String? email,
      String? gender,
      String? age,
      String? birthDay,
      String? profileImage,
      String? birthYear,
      String? mobile,
      String? ci,
      String? encId}) {
    this._id = id;
    this._nickName = nickName;
    this._name = name;
    this._email = email;
    this._gender = gender;
    this._age = age;
    this._birthDay = birthDay;
    this._birthYear = birthYear;
    this._profileImage = profileImage;
    this._mobile = mobile;
    this._ci = ci;
    this._encId = encId;
  }

  /// [response] : Android= NidProfile
  factory NaverLoginProfile.fromJson({required dynamic response}) {
    final json = jsonDecode(response);

    return NaverLoginProfile._(
      id: json[NaverLoginSdkConstantProfile.id],
      nickName: json[NaverLoginSdkConstantProfile.nickName],
      name: json[NaverLoginSdkConstantProfile.name],
      email: json[NaverLoginSdkConstantProfile.email],
      gender: json[NaverLoginSdkConstantProfile.gender],
      age: json[NaverLoginSdkConstantProfile.age],
      birthDay: json[NaverLoginSdkConstantProfile.birthDay],
      profileImage: json[NaverLoginSdkConstantProfile.profileImage],
      birthYear: json[NaverLoginSdkConstantProfile.birthYear],
      mobile: json[NaverLoginSdkConstantProfile.mobile],
      ci: json[NaverLoginSdkConstantProfile.ci],
      encId: json[NaverLoginSdkConstantProfile.encId],
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
