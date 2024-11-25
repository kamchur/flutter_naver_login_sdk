| [한국어](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ko-KR/README.md) | [English](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/packages/NaverLoginSDK/README.md) | [日本語](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ja-JP/README.md) | <br/>

[![Pub Version](https://img.shields.io/pub/v/naver_login_sdk?color=blue)](https://pub.dev/packages/naver_login_sdk)
![Static Badge](https://img.shields.io/badge/ios-v4.2.3-darkorange)
![Static Badge](https://img.shields.io/badge/android-v5.10.0-deepgreen)


# NaverLoginSDK

Flutter-Naver Login SDK <br/><br/>
Naver is a leading web service in South Korea. Since almost every citizen uses it, incorporating Naver Login would be an excellent choice if you're targeting South Korean users. It supports only iOS and Android OS. Please follow the guidelines below for setup. If you like ❤ this project, it will motivate us to provide more services in the future.

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
Please refer to this [https://pub.dev/packages/picture_button/install](https://pub.dev/packages/naver_login_sdk/install) for installation instructions.
```shell
flutter pub add naver_login_sdk
```

<br/>

## Common
First, visit [the Naver Developer Center](https://developers.naver.com/main/). Click on the Application > My Applications > Register Application button at the top of the page.
Select your application and find the Client ID and Client Secret in the "Overview" section. You will need these later for registration in your Flutter project. <br/>
<img src="https://github.com/user-attachments/assets/3ccfb285-d2c4-4030-b635-922297fd8806" alt="img" width="300"> <br/><br/>
Next, click on the API Settings tab and add environments under the "Login Open API Service Environment" section. Add both iOS and Android.
For iOS, you must include a URL Scheme. <br/>
(Snake or camel case is recommended. If unfamiliar, lowercase text will suffice)
For the Download URL, you can enter anything if there is no specific website.<br/>
<img src="https://github.com/user-attachments/assets/74f70f9f-1f24-4dec-ac02-474b39bcc34f" alt="iOS URL Scheme img" width="300">



<br/>

## iOS
| iOS | IDE |
|-----|-----|
| 9.0 🔼 | Xcode 9.0 🔼 |

Refer to [the iOS Development Guide](https://developers.naver.com/docs/login/ios/ios.md) for better understanding. <br/><br/>
Add the following code to the Info.plist file of your iOS project. <br/>
The [URL Scheme] value should match the URL Scheme you added earlier.
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

If you are using the overridden function `func application(_ app: UIApplication, open url: URL, options:...)` in your AppDelegate, <br/>
you can check the URL Scheme or return it as follows. <br/>

If there are no special conditions, simply return with `super.application(...)` without checking the URL Scheme.

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

Refer to [the Android Development Guide](https://developers.naver.com/docs/login/android/android.md) for better understanding. <br/>
For Android, no additional settings are required. Isn't that great? </br></br>
If you are using `proguard-rules.pro`, please configure it as follows.
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

To use the NaverLoginSDK package, you must first run the `initialize()` function in the `main()` function as follows.
The `urlScheme` parameter should be entered if developing for iOS.
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
Congratulations 🎉! You are now at the stage where you can execute 'Login.'
Use the `authenticate()` function to log in, and the `OAuthLoginCallback` listener to check whether the login was successful.
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

### Logout
You should also know how to 'logout' after logging in. There are two ways to do so:

1. The `logout()` function only deletes the token stored on the client side. This means the information is reset only on the current smartphone.
2. The `release()` function deletes tokens on both the client and server sides, resetting everything.

The `logout()` function does not have a callback listener, but the `release()` function can use the `OAuthLoginCallback` listener.
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

<br/>

### Profile
To retrieve the user's information after logging in, use the `profile()` function. <br/>
User information is delivered via the `ProfileCallback` listener, and you can use the `NaverLoginProfile` data model class to obtain the details. <br/>
Use `NaverLoginProfile.fromJson(response:)` to automatically parse and utilize user data.
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

<br/>

### Functions
| Name | Feature | Listener | 
|------|---------|----------|
| initialize | API Settings | :x:  |
| authenticate | Login | OAuthLoginCallback |
| refresh | Token Refresh | OAuthLoginCallback |
| logout | Logout | :x: |
| release | Unlink Account | OAuthLoginCallback |
| profile | User Information | ProfileCallback |
| getVersion | 	Library Version Info  | :x:  |
| getTokenType | 	Token Type Info  | :x:    |
| getExpireAt | Token Expiry Time  | :x:    |
| getAccessToken  | Access Token Info  | :x:  |
| getRefreshToken  | Refresh Token Info  | :x:  |

<br/>

## About
Thank you for using the NaverLoginSDK package. <br/>
I was genuinely happy while making this. Lastly, I will leave a few links to my humble activities.<br/><br/>
[Repository(GitHub)](https://github.com/Lagerstroemia-Indica)  <br/>
[LinkedIn](https://www.linkedin.com/in/lagerstroemia)  <br/>
[Inflearn(Courses)](https://www.inflearn.com/course/%EA%B1%B8%EC%9D%8C%EB%A7%88-%EC%BD%94%EB%94%A9-%EC%95%B1%EA%B0%9C%EB%B0%9C)  <br/>
[Youtube](https://www.youtube.com/watch?v=vKqbUce_JLs&t=238s)  <br/><br/>

Thanks💙