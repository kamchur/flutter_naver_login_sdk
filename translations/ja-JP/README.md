| [한국어](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ko-KR/README.md) | [English](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/packages/NaverLoginSDK/README.md) | [日本語](https://github.com/Lagerstroemia-Indica/flutter_naver_login_sdk/blob/main/translations/ja-JP/README.md) | <br/>

[![Pub Version](https://img.shields.io/pub/v/naver_login_sdk?color=blue)](https://pub.dev/packages/naver_login_sdk)
[![Static Badge](https://img.shields.io/badge/ios-v4.2.3-darkorange)](https://github.com/naver/naveridlogin-sdk-ios)
[![Static Badge](https://img.shields.io/badge/android-v5.11.0-deepgreen)](https://github.com/naver/naveridlogin-sdk-android)


# NaverLoginSDK

Flutter Naver Login SDK Package<br/><br/>
Naverは韓国を代表するウェブサービスです。ほぼすべての国民が利用しているため、韓国ユーザーをターゲットにする場合はNaverログインを組み込むことが非常に効果的です。
このサービスはiOSおよびAndroid OSのみをサポートしています。以下の手順に従ってセットアップを行ってください。

もしこのプロジェクトを気に入っていただけたら❤、今後さらに多くのサービスを提供するための励みになります！

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
以下のリンクを参考にしてインストールを行ってください。[https://pub.dev/packages/naver_login_sdk/install](https://pub.dev/packages/naver_login_sdk/install)
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
| 13.0 🔼 | Xcode 9.0 🔼 |

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
| API 35 🔼  | 11 🔼 |

Refer to [the Android Development Guide](https://developers.naver.com/docs/login/android/android.md) for better understanding. <br/>
Androidは特別な設定が必要ありません。本当に助かりますよね？ 😊 </br></br>
もし `proguard-rules.pro` を使用する場合は、次のように設定してください。

`3.0.0`バージョン [retrofit pro](https://github.com/square/retrofit/blob/trunk/retrofit/src/main/resources/META-INF/proguard/retrofit2.pro)追加.
```shell
-keep public class com.nhn.android.naverlogin.** {
  public protected *;
}
-keep public class com.navercorp.nid.** {
  public *;
}

# NidProfileDetail protect class field name(Gson Serialization)
-keep class com.navercorp.nid.profile.domain.vo.NidProfileDetail {
    <fields>;
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

NaverLoginSDKパッケージを使用するには、まず`main()`関数内で次のように`initialize()`関数を実行する必要があります。<br/>
`urlScheme`パラメーターは、iOSを開発する場合に記入してください。
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NaverLoginSDK.initialize(
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
<del>
NaverLoginSDK.authenticate(callback: OAuthLoginCallback(
  onSuccess: () {
    Log.d("onSuccess..");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpStatus:$httpStatus, message:$message");
  },
</del>

```dart
final bool isLogin = await NaverLoginSDK.login();

if (isLogin) {
  Log.d("isLogin!");

  // if you want to know userProfile
  final userProfile = await NaverLoginSDK.profile();
}
```

```dart
// use callback
NaverLoginSDK.login(callback: OAuthLoginCallback(
  onSuccess: () {
    Log.d("onSuccess..");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpStatus:$httpStatus, message:$message");
  },
```

<br/>

> [![Static Badge](https://img.shields.io/badge/android-v5.10.0-deepgreen)](https://github.com/naver/naveridlogin-sdk-android)では、ネイバーアプリがインストールされていない場合、継続的に`user_cancel` が返されるバグがありました。これはウェブでログインする際に発生するバグで、現在その内容を確認中のようです。NaverLoginSDK `1.0.5` バージョンから、ログイン時にネイバーアプリがインストールされていない場合、`onError` の`message` パラメーターを通じて`naverapp_not_installed` 値が返されるように修正されました。

> '2.2.0' stable version. Androidでウェブログインができるように修正しました。

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

### Logout
ログインしたら、「ログアウト」する方法も覚えておく必要があります。ログアウトには2つの方法があります。

1. `logout()` 関数は、クライアントに保存されたトークンのみを削除します。つまり、現在使用しているスマートフォンでのみ情報が初期化されます。
2. `release()` 関数は、クライアントおよびサーバーの両方でトークンを削除します。すべてが初期化された状態になります。

`logout()` 関数にはコールバックリスナーはありませんが、`release()` 関数には`OAuthLoginCallback` コールバックリスナーを使用できます。
```dart
final bool isLogout = await NaverLoginSDK.logout();

// or remove cache, like before `release` function.
final bool isLogout = await NaverLoginSDK.logout(isForced: true);
```

```dart
// logout callback
// + 3.1.2 : Added OAuthLogoutCallback listener.
NaverLoginSDK.logout(callback: OAuthLogoutCallback(
  onSuccess: () {
    Log.d("onSuccess..");
  },
  onFailure: (httpStatus, message) {
    Log.w("onFailure.. httpStatus:$httpStatus, message:$message");
  },
));
```

<del>

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

</del>

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

### Profile
ログイン後にそのユーザーの情報が必要な場合は、`profile()` 関数を使用すればよいです。<br/>
ユーザー情報は`ProfileCallback` コールバックリスナーを通じて渡され、`NaverLoginProfile` データモデルクラスを使って情報を取得できます。<br/>

情報の取得は `NaverLoginProfile.fromJson(response:)` 形式で行うことで、自動的にパースされ、ユーザーデータを活用できるようになります。
```dart
final userProfile = await NaverLoginSDK.profile();
```


```dart
// use callback
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
| initialize | API Settings | :x:  |
| ~~authenticate~~ | Login | OAuthLoginCallback |
| login | Login | OAuthLoginCallback |
| ~~refresh~~ | Token Refresh | OAuthLoginCallback |
| logout | Logout | OAuthLogoutCallback |
| ~~release~~ | Unlink Account | OAuthLoginCallback |
| profile | User Information | ProfileCallback |
| getVersion | 	Library Version Info  | :x:  |
| getTokenType | 	Token Type Info  | :x:    |
| getExpireAt | Token Expiry Time  | :x:    |
| getAccessToken  | Access Token Info  | :x:  |
| getRefreshToken  | Refresh Token Info  | :x:  |

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

## Widgets
<a href="https://developers.naver.com/docs/login/bi/bi.md" target="_blank">**ネイバーログインボタン使用ガイド**</a>ご参考ください <br/>
`NaverLoginButton`と `NaverLogoutButton`ウィジェットは <a href="https://pub.dev/packages/picture_button" target="_blank">**PictureButton**</a>ウィジェットを継承して作られました <br/>
(`PictureButton`は画像のサイズを自動的に計算して画面に表示するとても賢いウィジェットです)<br/>

<img src="https://github.com/user-attachments/assets/3e07ee87-1246-4172-9acc-9f668c9292f5" alt="NaverButton Resource Guide" width="300"><br/>
ネイバーの代表カラーが必要な場合は、`naver Color`カラーを適用してみましょう！
```dart
backgroundColor: Theme.of(context).naverColor,
```
<br/>

### NaverLoginButton
<img src="https://github.com/user-attachments/assets/a1274544-d5fa-40a3-b7f5-e78bcadaf589" alt="login" width="200" />

```dart
 NaverLoginButton(
    onPressed: (userProfile) {
      if (userProfile != null) {
        Log.d("ログイン成功! $userProfile");
      } else {
        Log.w("ログイン失敗..");
      }
    },
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
|`korean`|<p align="center"><img src="https://github.com/user-attachments/assets/573625bb-d869-440d-aa05-015db058ccde" alt="ko" width="200"></p>|
|`english`|<p align="center"><img src="https://github.com/user-attachments/assets/11e42f7f-4b9c-476b-8feb-c1dd538b9a11" alt="ko" width="200"></p>|


|`NaverButtonStyle`|`NaverButtonMode.green`|`NaverButtonMode.white`|`NaverButtonMode.dark`|
|------------------|-----------------------|------------------|-----------------------|
|`NaverButtonType.circleIcon`|<p align="center"><img src="https://github.com/user-attachments/assets/9211c72a-8d68-4328-ad48-99b78244d625" alt="circle" width="60"/></p>|<p align="center"><img src="https://github.com/user-attachments/assets/90a7da1a-1e85-491e-82b3-45a6e5ac927d" alt="circle" width="60" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/1fa3d1e8-38ed-4d83-b593-4a078d3de1c8" alt="circle" width="60"/></p>|
|`NaverButtonType.rectangleIcon`|<p align="center"><img src="https://github.com/user-attachments/assets/612dfcfb-a62a-4992-a62f-42583328e057" alt="rectangle" width="60"/></p>|<p align="center"><img src="https://github.com/user-attachments/assets/f183f041-095f-428d-9b88-d7dcbf333daf" alt="rectangle" width="60"/></p>|<p align="center"><img src="https://github.com/user-attachments/assets/686df457-d93c-4890-a45b-79016abe1bc6" alt="rectangle" width="60"/></p>|
|`NaverButtonType.rectangleBar`|<p align="center"><img src="https://github.com/user-attachments/assets/932e778a-a647-41c3-b6f7-791544f772f7" alt="rectangleBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/22ff9b07-f37a-46e6-b271-c0aaf79016f9" alt="rectangleBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/3e4e6ce4-3837-4985-b79c-de4593228c47" alt="rectangleBar" width="200" /></p>|
|`NaverButtonType.rectangleWithNaverBar`|<p align="center"><img src="https://github.com/user-attachments/assets/55e2c16e-a96c-4b8d-9ffe-03c32b9cf79c" alt="rectangleWithNaverBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/c0b15bf1-d8fb-4497-81e9-70fdc86fd615" alt="rectangleWithNaverBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/d07fac1b-865b-41d9-9c37-998d4077115c" alt="rectangleWithNaverBar" width="200" /></p>|

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>

### NaverLogoutButton
<img src="https://github.com/user-attachments/assets/3512d0b9-f361-4897-8a8a-e94bca413cd0" alt="login" width="200" />

```dart
  NaverLogoutButton(
    onPressed: (isLogout) {
      if (isLogout) {
        Log.d("ログアウト成功!");
      } else {
        Log.w("ログアウト失敗..");
      }
    },
    style: NaverLogoutButtonStyle(
      language: NaverButtonLanguage.english,
      mode: NaverButtonMode.green
    ),
    width: 200,
  ),
```

|`NaverButtonStyle`|`NaverButtonMode.green`|`NaverButtonMode.white`|`NaverButtonMode.dark`|
|------------------|-----------------------|------------------|-----------------------|
|`NaverButtonLanguage.korean`|<p align="center"><img src="https://github.com/user-attachments/assets/99a133de-7927-4670-bf4e-7460e05f1576" alt="rectangleWithNaverBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/1d99ab93-537f-4511-9f30-b3f1980b28e5" alt="rectangleWithNaverBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/08608eda-1a93-4166-9ab4-e1b40842935a" alt="rectangleWithNaverBar" width="200" /></p>|
|`NaverButtonLanguage.english`|<p align="center"><img src="https://github.com/user-attachments/assets/1f327611-ade0-43ca-b8a2-2901b642888a" alt="rectangleWithNaverBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/c317f1dd-f9d7-49dd-bab4-64489ec96a5d" alt="rectangleWithNaverBar" width="200" /></p>|<p align="center"><img src="https://github.com/user-attachments/assets/1ca42f53-0610-4c30-a612-2a96ea9b50f6" alt="rectangleWithNaverBar" width="200" /></p>|

<p align="right"><a href="#getting-started">🔼</a></p>
<br/>
<br/>

## About
NaverLoginSDKパッケージをご利用いただきありがとうございます。<br/>
開発中、とても楽しかったです。さらに、私の少しばかりの活動リンクを記載して、締めくくろうと思います。<br/><br/>
[Repository(GitHub)](https://github.com/kamchur)  <br/>

ありがとな💙