| [한국어](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ko-KR/README.md) | [English](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/packages/NaverLoginSDK/README.md) | [日本語](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ja-JP/README.md) | <br/>

[![Pub Version](https://img.shields.io/pub/v/naver_login_sdk?color=blue)](https://pub.dev/packages/naver_login_sdk)
![Static Badge](https://img.shields.io/badge/ios-v4.2.3-darkorange)
![Static Badge](https://img.shields.io/badge/android-v5.10.0-deepgreen)


# NaverLoginSDK

Flutter-Naver Login SDK <br/><br/>
대한민국 플러터 유저들이 네이버 로그인을 원활하게 이용하시도록 패키지를 제작하였습니다. <br/>
iOS와 Android OS만을 지원합니다. 아래의 가이드라인에 따라서 설정하시면 되겠습니다. <br/>
'좋아요❤'를 눌러주시면 앞으로 다양한 서비스를 제공 드릴때 힘이 날 것 같습니다.

<br/>

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

<br/>

## Install
[https://pub.dev/packages/picture_button/install](https://pub.dev/packages/naver_login_sdk/install)를 참고하여 설치 해주세요.
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
| 9.0 🔼 | Xcode 9.0 🔼 |

[iOS개발가이드](https://developers.naver.com/docs/login/ios/ios.md)를 참고하시면서 내용을 이해하면 더욱 도움이 됩니다. <br/><br/>
작업하시려는 ios의 Info.plist파일에 아래와 같이 추가해주세요. <br/>
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

AppDelegate에서 `func application(_ app: UIApplication, open url: URL, options:...)`오버라이드 함수를 사용하고 있다면 <br/>
URL Scheme를 확인하거나 다음과 같이 return해주세요. <br/>
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
```shell
-keep public class com.nhn.android.naverlogin.** {
public protected *;
}
-keep public class com.navercorp.nid.** {
public *;
}
```

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
  },
));
```
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
  onError: (errorCode, message) {
    Log.e("onError.. errorCode:$errorCode, message:$message");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpStatus:$httpStatus, message:$message");
  },
  onSuccess: () {
    Log.d("onSuccess..");
  },
));
```

<br/>

### Profile
로그인 이후 해당 유저의 정보가 필요한 경우 `profile()`함수를 사용하면 되겠습니다.</br>
유저정보는 `ProfileCallback`콜백 리스너를 통해서 전달받고 `NaverLoginProfile`데이터 모델 클래스를 이용해서 정보를 획득하시면 됩니다. </br>
획득은 `NaverLoginProfile.fromJson(response: )`형태로 받으시면 자동으로 파싱되어 유저 데이터를 활용할 수 있도록 하였습니다. <br/>
```dart
NaverLoginSDK.profile(callback: ProfileCallback(
  onError: (errorCode, message) {
    Log.e("onError.. message:$message");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpsStatus:$httpStatus, message:$message");
  },
  onSuccess: (resultCode, message, response) {
    Log.i("onSuccess.. resultCode:$resultCode, message:$message, profile:$response");
    final profile = NaverLoginProfile.fromJson(response: response);
    Log.i("profile:$profile");
  },
));

<br/>

```

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

<br/>

## About
NaverLoginSDK패키지를 이용해주셔서 감사합니다. <br/>
만들면서 정말 행복했습니다. 추가적으로 저의 소소한 활동 링크를 남기고 마무리 하려고 합니다.<br/><br/>
[Repository(GitHub)](https://github.com/Lagerstroemia-Indica)  <br/>
[LinkedIn](https://www.linkedin.com/in/lagerstroemia)  <br/>
[Inflearn(인프런강의)](https://www.inflearn.com/course/%EA%B1%B8%EC%9D%8C%EB%A7%88-%EC%BD%94%EB%94%A9-%EC%95%B1%EA%B0%9C%EB%B0%9C)  <br/>
[Youtube](https://www.youtube.com/watch?v=vKqbUce_JLs&t=238s)  <br/><br/>

감사합니다🩵💙