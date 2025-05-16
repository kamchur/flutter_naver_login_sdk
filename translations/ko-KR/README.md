| [한국어](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ko-KR/README.md) | [English](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/packages/NaverLoginSDK/README.md) | [日本語](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ja-JP/README.md) | <br/>

[![Pub Version](https://img.shields.io/pub/v/naver_login_sdk?color=blue)](https://pub.dev/packages/naver_login_sdk)
[![Static Badge](https://img.shields.io/badge/ios-v4.2.3-darkorange)](https://github.com/naver/naveridlogin-sdk-ios)
[![Static Badge](https://img.shields.io/badge/android-v5.10.0-deepgreen)](https://github.com/naver/naveridlogin-sdk-android)


# NaverLoginSDK

Flutter Naver Login SDK Package<br/><br/>
대한민국 플러터 유저들이 네이버 로그인을 원활하게 이용하시도록 패키지를 제작하였습니다. <br/>
iOS와 Android OS만을 지원합니다. 아래의 가이드라인에 따라서 설정하시면 되겠습니다. <br/>
'좋아요❤'를 눌러주시면 앞으로 다양한 서비스를 제공 드릴때 힘이 날 것 같습니다.

<br/>

## Getting Started

- [Install](#install)
- [Common Setting](#common)
- [Usage](#usage)
- [Login](#login)
- [Logout](#logout)
- [User Profile](#profile)
- [Functions](#functions)
- [LoginButtonWidget](#naverloginbutton)
- [LogoutButtonWidget](#naverlogoutbutton)
- [About](#about)

<br/>

## Install
[https://pub.dev/packages/naver_login_sdk/install](https://pub.dev/packages/naver_login_sdk/install)를 참고하여 설치 해주세요.
```shell
flutter pub add naver_login_sdk
```

<br/>

## Common
먼저, [네이버 개발자 센터](https://developers.naver.com/main/)에 접속합니다. 페이지 상단에 *Application/내 애플리케이션/Application 등록* 을 클릭합니다. <br/>
본인의 애플리케이션을 클릭한 뒤 '개요'의 Client ID, Client Secret을 확인합니다. **추후 Flutter프로젝트 내에서 등록이 필요하기 떄문**입니다. </br>
<img src="https://github.com/user-attachments/assets/3ccfb285-d2c4-4030-b635-922297fd8806" alt="img" width="300"> <br/><br/>
그리고, 'API설정'을 클릭한 뒤 로그인 오픈 API서비스 환경탭의 '환경추가'를 하시고 iOS와 Android를 추가해주세요. <br/>
iOS는 Android와 다르게 'URL Scheme'이라는 것을 꼭 추가해주어야 합니다. <br/>
(Snake또는 Camel기법을 권장합니다. 처음 들어보신다면 소문자로만 작성하셔도 무방합니다)<br/>
다운로드 URL은 특정사이트가 없다면 아무렇게나 입력하셔도 괜찮습니다. <br/>
<img src="https://github.com/user-attachments/assets/74f70f9f-1f24-4dec-ac02-474b39bcc34f" alt="iOS URL Scheme img" width="300">



<br/>

## iOS
| iOS | IDE |
|-----|-----|
| 13.0 🔼 | Xcode 9.0 🔼 |

[iOS개발가이드](https://developers.naver.com/docs/login/ios/ios.md)를 참고하시면서 내용을 이해하면 더욱 도움이 됩니다. <br/><br/>
작업하시려는 iOS의 Info.plist파일에 아래와 같이 추가해주세요. <br/>
[URL Scheme]값은 위에서 추가한 URL Scheme과 동일하게 입력하면 되겠습니다.
#### Info.plist
```xml
  <!--Url Scheme Setting-->
  <key>CFBundleURLTypes</key>
  <array>
      <dict>
          <key>CFBundleTypeRole</key>
          <string>Editor</string>
          <key>CFBundleURLSchemes</key>
          <array>
              <string>[URL Scheme]</string>
          </array>
      </dict>
  </array>
  <!--Query Scheme Setting-->
  <key>LSApplicationQueriesSchemes</key>
  <array>
      <string>naversearchapp</string>
      <string>naversearchthirdlogin</string>
  </array>

  <!--Always IPhone Device(Not used MAC)-->
  <key>LSRequiresIPhoneOS</key>
  <true/>
```
<br/>

AppDelegate에서 `func application(_ app: UIApplication, open url: URL, options:...)`오버라이드 함수를 사용하고 있다면 URL Scheme를 확인하거나 다음과 같이 return해주세요. <br/>
특별한 일이 없다면 URL Scheme을 확인하지 않고 `super.application(...)`으로 return하면 되겠습니다.

#### AppDelegate.swift
```swift
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {        
      if url.scheme == "[URL Scheme]" {
          return super.application(app, open: url, options: options)
      }
      
      ...

      return true
  }
```

<br/>

## Android
| Target SDK | JDK |
|------------|-----|
| API 21 🔼  | 11 🔼 |

[Android개발가이드](https://developers.naver.com/docs/login/android/android.md)를 참고하시면서 내용을 이해하면 더욱 도움이 됩니다.<br/>
Android는 따로 설정이 필요하지 않습니다. 정말 다행이죠? </br></br>
만약에 `proguard-rules.pro`를 사용하신다면 다음과 같이 설정해주세요.

`3.0.0`버전 [retrofit pro](https://github.com/square/retrofit/blob/trunk/retrofit/src/main/resources/META-INF/proguard/retrofit2.pro)추가
```shell
-keep public class com.nhn.android.naverlogin.** {
  public protected *;
}
-keep public class com.navercorp.nid.** {
  public *;
}

# With R8 full mode, it sees no subtypes of Retrofit interfaces since they are created with a Proxy
# and replaces all potential values with null. Explicitly keeping the interfaces prevents this.
-if interface * { @retrofit2.http.* <methods>; }
-keep,allowobfuscation interface <1>

# With R8 full mode generic signatures are stripped for classes that are not
# kept. Suspend functions are wrapped in continuations where the type argument
# is used.
-keep,allowobfuscation,allowshrinking class kotlin.coroutines.Continuation

# R8 full mode strips generic signatures from return types if not kept.
-if interface * { @retrofit2.http.* public *** *(...); }
-keep,allowoptimization,allowshrinking,allowobfuscation class <3>

# With R8 full mode generic signatures are stripped for classes that are not kept.
-keep,allowobfuscation,allowshrinking class retrofit2.Response
```

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

## Usage

#### import
```dart
import 'package:naver_login_sdk/naver_login_sdk.dart';
```
<br/>

NaverLoginSDK패키지를 사용하기 위해서 가장 먼저 `main()`함수에서 다음과 같이 `initialize()`함수를 실행해주어야 합니다. <br/>
`urlScheme`파라메터는 iOS를 개발한다면 기입해주시면 되겠습니다.
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NaverLoginSDK.initialize(
    urlScheme: urlScheme, 
    clientId: clientId, 
    clientSecret: clientSecret,
    clientName: clientName
  );

  runApp(const MyApp());
}
```
<br/>

### Login
드디어 우리가 실행하고 싶었던 '로그인'을 할 수 있는 단계에 왔습니다. 축하드립니다🎉 </br>
`authenticate()`라는 함수로 로그인을 하며 `OAuthLoginCallback`콜백 리스너로 로그인이 잘되었는지 확인할 수 있습니다.</br>
```dart
NaverLoginSDK.authenticate(callback: OAuthLoginCallback(
  onSuccess: () {
    Log.d("onSuccess..");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpStatus:$httpStatus, message:$message");
  },
  onError: (errorCode, message) {
    Log.e("onError.. errorCode:$errorCode, message:$message");
  }
));
```

<br/>

> [![Static Badge](https://img.shields.io/badge/android-v5.10.0-deepgreen)](https://github.com/naver/naveridlogin-sdk-android)에서 네이버 앱이 설치되어 있지 않은 경우 지속해서 `user_cancel`이 return되는 버그가 있었습니다. 웹으로 로그인하는 경우 발생되는 버그이므로 현재 그 내용을 확인 중인 것 같습니다. NaverLoginSDK `1.0.5`버전부터 로그인시 네이버 앱이 설치되어 있지 않은 경우 `onError`의 `message`파라메터를 통해 `naverapp_not_installed`값이 return되도록 수정하였습니다.

> `2.2.0` stable version. Android에서 웹 로그인이 가능하도록 수정하였습니다.

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

### Logout
로그인을 했으면 '로그아웃'을 하는 방법도 알아야 합니다. '로그아웃'을 하는 방법에 두 가지가 있습니다.<br/>
1. `logout()`함수는 클라이언트에 저장된 토큰만 삭제됩니다. 그 뜻은 현재 사용하고 있는 스마트폰에서만 정보가 초기화 되는 것 입니다. <br/>
2. `release()`함수는 클라이언트&서버 모두 토큰이 삭제됩니다. 모든 것이 초기화된다고 생각하시면 되겠습니다.<br/>

`logout()`함수는 따로 콜백 리스너가 없지만, `release()`함수는 `OAuthLoginCallback`콜백 리스너를 사용할 수 있습니다.

```dart
// logout
NaverLoginSDK.logout();

// release
NaverLoginSDK.release(callback: OAuthLoginCallback(
  onSuccess: () {
    Log.d("onSuccess..");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpStatus:$httpStatus, message:$message");
  },
  onError: (errorCode, message) {
    Log.e("onError.. errorCode:$errorCode, message:$message");
  }
));
```

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

### Profile
로그인 이후 해당 유저의 정보가 필요한 경우 `profile()`함수를 사용하면 되겠습니다.</br>
유저정보는 `ProfileCallback`콜백 리스너를 통해서 전달받고 `NaverLoginProfile`데이터 모델 클래스를 이용해서 정보를 획득하시면 됩니다. </br>
획득은 `NaverLoginProfile.fromJson(response: )`형태로 받으시면 자동으로 파싱되어 유저 데이터를 활용할 수 있도록 하였습니다. <br/>
```dart
NaverLoginSDK.profile(callback: ProfileCallback(
  onSuccess: (resultCode, message, response) {
    Log.i("onSuccess.. resultCode:$resultCode, message:$message, profile:$response");
    
    final profile = NaverLoginProfile.fromJson(response: response);
    Log.i("profile:$profile");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpsStatus:$httpStatus, message:$message");
  },
  onError: (errorCode, message) {
    Log.e("onError.. message:$message");
  }
));
```

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

### Functions
| Name | Feature | Listener | 
|------|---------|----------|
| initialize | API설정 | :x:  |
| authenticate | 로그인 | OAuthLoginCallback |
| refresh | 토큰재발급 | OAuthLoginCallback |
| logout | 로그아웃 | :x: |
| release | 연동해제 | OAuthLoginCallback |
| profile | 유저정보 | ProfileCallback |
| getVersion | 라이브러리 버전 정보  | :x:  |
| getTokenType | 토큰 타입 정보  | :x:    |
| getExpireAt | 토큰 만료 시간  | :x:    |
| getAccessToken  | 접근 토큰 정보  | :x:  |
| getRefreshToken  | 갱신 토큰 정보  | :x:  |

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

## Widgets
<a href="https://developers.naver.com/docs/login/bi/bi.md" target="_blank">**네이버 로그인 버튼 사용가이드**</a>를 참고해주세요. <br/>
`NaverLoginButton`과 `NaverLogoutButton`위젯은 <a href="https://pub.dev/packages/picture_button" target="_blank">**PictureButton**</a>위젯을 상속하여 만들어졌습니다. <br/>
(`PictureButton`은 이미지 크기를 자동으로 계산하여 화면에 표출하는 아주 똑똑한 위젯입니다)<br/>

<img src="https://github.com/user-attachments/assets/3e07ee87-1246-4172-9acc-9f668c9292f5" alt="NaverButton Resource Guide" height="56"><br/>
만약에 네이버 대표 색상이 필요하다면 `naverColor` 색상을 적용해보세요!
```dart
backgroundColor: Theme.of(context).naverColor,
```
<br/>

### NaverLoginButton
<img src="https://github.com/user-attachments/assets/a1274544-d5fa-40a3-b7f5-e78bcadaf589" alt="login" height="60" />

```dart
 NaverLoginButton(
    onPressed: () => NaverLoginSDK.authenticate(),
    style: NaverLoginButtonStyle(
        language: NaverButtonLanguage.english,
        mode: NaverButtonMode.green,
        type: NaverButtonType.rectangleBar
    ),
    width: 200,
  ),
```
|`NaverButtonLanguage`|Output|
|--------|------|
|`korean`|<p align="center"><img src="https://github.com/user-attachments/assets/573625bb-d869-440d-aa05-015db058ccde" alt="ko" height="60"></p>|
|`english`|<p align="center"><img src="https://github.com/user-attachments/assets/11e42f7f-4b9c-476b-8feb-c1dd538b9a11" alt="ko" height="60"></p>|


|`NaverButtonStyle`|`NaverButtonMode.green`|`NaverButtonMode.white`|`NaverButtonMode.dark`|
|------------------|-----------------------|------------------|-----------------------|
|`NaverButtonType.circleIcon`|<p align="center"><img src="https://github.com/user-attachments/assets/9211c72a-8d68-4328-ad48-99b78244d625" alt="circle" width="60"/></p>|<p align="center"><img src="https://github.com/user-attachments/assets/90a7da1a-1e85-491e-82b3-45a6e5ac927d" alt="circle" width="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/1fa3d1e8-38ed-4d83-b593-4a078d3de1c8" alt="circle" width="60"/></p>|
|`NaverButtonType.rectangleIcon`|<p align="center"><img src="https://github.com/user-attachments/assets/612dfcfb-a62a-4992-a62f-42583328e057" alt="rectangle" width="60"/></p>|<p align="center"><img src="https://github.com/user-attachments/assets/f183f041-095f-428d-9b88-d7dcbf333daf" alt="rectangle" width="60"/></p>|<p align="center"><img src="https://github.com/user-attachments/assets/686df457-d93c-4890-a45b-79016abe1bc6" alt="rectangle" width="60"/></p>|
|`NaverButtonType.rectangleBar`|<p align="center"><img src="https://github.com/user-attachments/assets/932e778a-a647-41c3-b6f7-791544f772f7" alt="rectangleBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/22ff9b07-f37a-46e6-b271-c0aaf79016f9" alt="rectangleBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/3e4e6ce4-3837-4985-b79c-de4593228c47" alt="rectangleBar" height="60" /></p>|
|`NaverButtonType.rectangleWithNaverBar`|<p align="center"><img src="https://github.com/user-attachments/assets/55e2c16e-a96c-4b8d-9ffe-03c32b9cf79c" alt="rectangleWithNaverBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/c0b15bf1-d8fb-4497-81e9-70fdc86fd615" alt="rectangleWithNaverBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/d07fac1b-865b-41d9-9c37-998d4077115c" alt="rectangleWithNaverBar" height="60" /></p>|

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

### NaverLogoutButton
<img src="https://github.com/user-attachments/assets/3512d0b9-f361-4897-8a8a-e94bca413cd0" alt="login" height="60" />

```dart
  NaverLogoutButton(
    onPressed: () => NaverLoginSDK.logout(),
    style: NaverLogoutButtonStyle(
      language: NaverButtonLanguage.english,
      mode: NaverButtonMode.green
    ),
    width: 200,
  ),
```

|`NaverButtonStyle`|`NaverButtonMode.green`|`NaverButtonMode.white`|`NaverButtonMode.dark`|
|------------------|-----------------------|------------------|-----------------------|
|`NaverButtonLanguage.korean`|<p align="center"><img src="https://github.com/user-attachments/assets/99a133de-7927-4670-bf4e-7460e05f1576" alt="rectangleWithNaverBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/1d99ab93-537f-4511-9f30-b3f1980b28e5" alt="rectangleWithNaverBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/08608eda-1a93-4166-9ab4-e1b40842935a" alt="rectangleWithNaverBar" height="60" /></p>|
|`NaverButtonLanguage.english`|<p align="center"><img src="https://github.com/user-attachments/assets/1f327611-ade0-43ca-b8a2-2901b642888a" alt="rectangleWithNaverBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/c317f1dd-f9d7-49dd-bab4-64489ec96a5d" alt="rectangleWithNaverBar" height="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/1ca42f53-0610-4c30-a612-2a96ea9b50f6" alt="rectangleWithNaverBar" height="60" /></p>|

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>
<br/>

## About
NaverLoginSDK패키지를 이용해주셔서 감사합니다. <br/>
만들면서 정말 행복했습니다. 추가적으로 저의 소소한 활동 링크를 남기고 마무리 하려고 합니다.<br/><br/>
[Repository(GitHub)](https://github.com/hamhoney)  <br/>
[LinkedIn](https://www.linkedin.com/in/lagerstroemia)  <br/>
[Inflearn(인프런강의)](https://www.inflearn.com/course/%EA%B1%B8%EC%9D%8C%EB%A7%88-%EC%BD%94%EB%94%A9-%EC%95%B1%EA%B0%9C%EB%B0%9C)  <br/>
[Youtube](https://www.youtube.com/watch?v=OVd35X7yCro)  <br/><br/>

감사합니다💙