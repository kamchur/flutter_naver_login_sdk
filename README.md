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
            <key>CFBundleURLName</key>
            <string>com.nhncorp.oauthLogin</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>thirdparty20samplegame</string>
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

  <!--HTTP Loads Setting-->
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSExceptionDomains</key>
        <dict>
            <key>naver.com</key>
            <dict>
                <key>NSExceptionAllowsInsecureHTTPLoads</key>
                <true/>
                <key>NSExceptionRequiresForwardSecrecy</key>
                <false/>
                <key>NSIncludesSubdomains</key>
                <true/>
            </dict>
            <key>naver.net</key>
            <dict>
                <key>NSExceptionAllowsInsecureHTTPLoads</key>
                <true/>
                <key>NSExceptionRequiresForwardSecrecy</key>
                <false/>
                <key>NSIncludesSubdomains</key>
                <true/>
            </dict>
        </dict>
    </dict>
```
