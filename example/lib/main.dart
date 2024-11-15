import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



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
                    final clientId = 'KH4kCq8piNCS57oematF';
                    final clientSecret = 'dn5kOT07i7';
                    final clientName = "Flutter NaverLogin";

                    NaverLoginSDK.initialize(
                      clientId: clientId,
                      clientSecret: clientSecret,
                      clientName: clientName
                    );
                  },
                  child: Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    NaverLoginSDK.authenticate();
                  },
                  child: Text("GetProfile"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
