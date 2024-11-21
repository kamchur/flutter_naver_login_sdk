import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';

const clientId = 'KH4kCq8piNCS57oematF';
const clientSecret = 'dn5kOT07i7';
const clientName = "Flutter NaverLogin";

/// e-mail: b3xlon9@gmail.com
/// Call me whenever Naver Team
void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  // Init
  NaverLoginSDK.initialize(urlScheme: "flutterNaverLogin", clientId: clientId, clientSecret: clientSecret);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: FittedBox(child: Text("Flutter-NaverLogin Demo")),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
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
                    },
                    child: Text("Login"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      NaverLoginSDK.refresh(callback: OAuthLoginCallback(
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
                    },
                    child: Text("Refresh"),
                  ),
                  ElevatedButton(
                    onPressed: () {
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
                    },
                    child: Text("Profile"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      NaverLoginSDK.logout();
                    },
                    child: Text("Logout"),
                  ),
                  ElevatedButton(
                    onPressed: () {
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
                    },
                    child: Text("Release"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String version = await NaverLoginSDK.getVersion();
                      Log.i("getVersion():$version");
                    },
                    child: Text("Version"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final tokenType = await NaverLoginSDK.getTokenType();
                      Log.i("tokenType:$tokenType");
                    },
                    child: Text("TokenType"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final expireAt = await NaverLoginSDK.getExpireAt();
                      Log.i("expireAt:$expireAt");
                    },
                    child: Text("ExpireAt(Time)"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final accessToken = await NaverLoginSDK.getAccessToken();
                      Log.i("accessToken:$accessToken");
                    },
                    child: Text("AccessToken"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final refreshToken = await NaverLoginSDK.getRefreshToken();
                      Log.i("refreshToken:$refreshToken");
                    },
                    child: Text("RefreshToken"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
