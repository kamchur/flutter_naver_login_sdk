import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';

const clientId = 'KH4kCq8piNCS57oematF';
const clientSecret = 'dn5kOT07i7';
const clientName = "Flutter NaverLogin";

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
  // MethodChannel methodChannel = MethodChannel(NaverLoginSdkConstant.channelName);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
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
                    ));
                  },
                  child: Text("Release"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
