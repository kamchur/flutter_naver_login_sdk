| [한국어](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ko-KR/README.md) | [English](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/packages/NaverLoginSDK/README.md) | [日本語](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ja-JP/README.md) | <br/>

[![Pub Version](https://img.shields.io/pub/v/naver_login_sdk?color=blue)](https://pub.dev/packages/naver_login_sdk)
![Static Badge](https://img.shields.io/badge/ios-v4.2.3-darkorange)
![Static Badge](https://img.shields.io/badge/android-v5.10.0-deepgreen)


# NaverLoginSDK

Flutter-Naver Login SDK <br/><br/>
Naverは韓国を代表するウェブサービスです。ほぼすべての国民が利用しているため、韓国ユーザーをターゲットにする場合はNaverログインを組み込むことが非常に効果的です。
このサービスはiOSおよびAndroid OSのみをサポートしています。以下の手順に従ってセットアップを行ってください。

もしこのプロジェクトを気に入っていただけたら❤、今後さらに多くのサービスを提供するための励みになります！

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
以下のリンクを参考にしてインストールを行ってください。[https://pub.dev/packages/picture_button/install](https://pub.dev/packages/naver_login_sdk/install)
```shell
flutter pub add naver_login_sdk
```

<br/>

## Common
まず、Naver開発者センターにアクセスします。[the Naver Developer Center](https://developers.naver.com/main/)<br/>
ページ上部の 「the Application > My Applications > Register Application」 をクリックします。<br/><br/>

自身のアプリケーションを選択した後、「概要」 セクションで Client ID と Client Secret を確認してください。<br/>
これらは後ほどFlutterプロジェクト内で登録する必要があります。<br/>

<img src="https://github.com/user-attachments/assets/3ccfb285-d2c4-4030-b635-922297fd8806" alt="img" width="300"> <br/><br/>
そして、「API設定」 をクリックし、ログインオープンAPIサービスの**「環境」** タブで 「環境追加」 を行い、iOSとAndroidを追加してください。<br/><br/>

iOSの場合は、Androidとは異なり**「URLスキーム」** を必ず追加する必要があります。<br/>
（スネークケースまたはキャメルケースを推奨します。もしこれらを初めて聞いた場合は、小文字だけで作成しても問題ありません。）<br/>

ダウンロードURLについては、特定のサイトがなければ適当な値を入力しても構いません。<br/>
<img src="https://github.com/user-attachments/assets/74f70f9f-1f24-4dec-ac02-474b39bcc34f" alt="iOS URL Scheme img" width="300">



<br/>

## iOS
| iOS | IDE |
|-----|-----|
| 9.0 🔼 | Xcode 9.0 🔼 |

Refer to [the iOS Development Guide](https://developers.naver.com/docs/login/ios/ios.md) for better understanding. <br/><br/>
作業するiOSのInfo.plistファイルに、以下のように追記してください。<br/>
[URL Scheme] の値は、先ほど設定したURLスキームと同じものを入力してください。
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

AppDelegateで `func application(_ app: UIApplication, open url: URL, options:...)` をオーバーライド関数として使用している場合、 <br/>
URL Schemeを確認するか、次のようにreturnしてください。  <br/>

特別な理由がない限り、URL Schemeを確認せずに `super.application(...)` でreturnすれば問題ありません。

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
Androidは特別な設定が必要ありません。本当に助かりますよね？ 😊 </br></br>
もし `proguard-rules.pro` を使用する場合は、次のように設定してください。
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

NaverLoginSDKパッケージを使用するには、まず`main()`関数内で次のように`initialize()`関数を実行する必要があります。<br/>
`urlScheme`パラメーターは、iOSを開発する場合に記入してください。
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
ついに私たちが実行したかった**「ログイン」**の段階に到達しました。おめでとうございます🎉<br/>

`authenticate()`という関数を使ってログインを行い、`OAuthLoginCallback` コールバックリスナーでログインが正常に行われたか確認することができます。
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
ログインしたら、「ログアウト」する方法も覚えておく必要があります。ログアウトには2つの方法があります。

1. `logout()` 関数は、クライアントに保存されたトークンのみを削除します。つまり、現在使用しているスマートフォンでのみ情報が初期化されます。
2. `release()` 関数は、クライアントおよびサーバーの両方でトークンを削除します。すべてが初期化された状態になります。

`logout()` 関数にはコールバックリスナーはありませんが、`release()` 関数には`OAuthLoginCallback` コールバックリスナーを使用できます。
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
ログイン後にそのユーザーの情報が必要な場合は、`profile()` 関数を使用すればよいです。<br/>
ユーザー情報は`ProfileCallback` コールバックリスナーを通じて渡され、`NaverLoginProfile` データモデルクラスを使って情報を取得できます。<br/>

情報の取得は `NaverLoginProfile.fromJson(response:)` 形式で行うことで、自動的にパースされ、ユーザーデータを活用できるようになります。
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
NaverLoginSDKパッケージをご利用いただきありがとうございます。<br/>
開発中、とても楽しかったです。さらに、私の少しばかりの活動リンクを記載して、締めくくろうと思います。<br/><br/>
[Repository(GitHub)](https://github.com/Lagerstroemia-Indica)  <br/>
[LinkedIn](https://www.linkedin.com/in/lagerstroemia)  <br/>
[Inflearn(Courses)](https://www.inflearn.com/course/%EA%B1%B8%EC%9D%8C%EB%A7%88-%EC%BD%94%EB%94%A9-%EC%95%B1%EA%B0%9C%EB%B0%9C)  <br/>
[Youtube](https://www.youtube.com/watch?v=vKqbUce_JLs&t=238s)  <br/><br/>

ありがとな💙