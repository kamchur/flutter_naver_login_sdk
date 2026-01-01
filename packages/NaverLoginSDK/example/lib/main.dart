import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';

const urlScheme = 'flutterNaverLogin';      // Only iOS, Android was not used.
const clientId = 'KH4kCq8piNCS57oematF';    // iOS - consumerKey
const clientSecret = 'sXQTGsyP39';          // iOS - consumerSecret
const clientName = "Flutter NaverLogin";    // iOS - appName

/// ISSUE]
/// e-mail: noccippuca@gmail.com
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init - Change your API Key.
  await NaverLoginSDK.initialize(
    urlScheme: urlScheme,
    clientId: clientId,
    clientSecret: clientSecret,
    clientName: clientName
  );

  runApp(MaterialApp(
    home: const MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Flutter-NaverLoginSDK Demo")),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NaverLoginButton(
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

                          if (message == 'naverapp_not_installed') {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: Text('Alarm'),
                              content: Text('NaverApp not installed'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('ok', style: TextStyle(color: Colors.blueAccent),),
                                )
                              ],
                            ),);
                          }
                        },
                      ));
                    },
                    style: NaverLoginButtonStyle(
                        language: NaverButtonLanguage.english,
                        mode: NaverButtonMode.green,
                        type: NaverButtonType.rectangleBar
                    ),
                    width: 200,
                  ),
                  SizedBox(height: 9.0,),
                  NaverLogoutButton(
                    onPressed: () => NaverLoginSDK.logout(),
                    style: NaverLogoutButtonStyle(
                        language: NaverButtonLanguage.english,
                        mode: NaverButtonMode.green
                    ),
                    width: 200,
                  ),
                  SizedBox(height: 12.0,),
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
                      NaverLoginSDK.logout(callback: OAuthLogoutCallback(
                        onSuccess: () {
                          Log.d("onSuccess..");
                        },
                        onFailure: (httpStatus, message) {
                          Log.w("onFailure.. httpStatus:$httpStatus, message:$message");
                        },
                      ));
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
                      Log.i("getVersion:$version");
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
