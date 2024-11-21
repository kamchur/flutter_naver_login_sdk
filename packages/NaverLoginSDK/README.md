# NaverLoginSDK

Flutter-Naver Login SDK

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## iOS
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
