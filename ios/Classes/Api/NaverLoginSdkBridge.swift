//
//  NaverLoginSdkBridge.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/18/24.
//

import Foundation
import NaverThirdPartyLogin

extension NaverLoginSdkPlugin {
    func initialize(args arguments: [String: String]?) {
        if arguments != nil {
            // print("NaverLoginSdkBridge.. arguments:\(arguments)")
            naverConnection = NaverThirdPartyLoginConnection.getSharedInstance()
            self.naverConnection?.delegate = self
            
            // NaverLogin into NaverApplication
            self.naverConnection?.isNaverAppOauthEnable = true
            // NaverLogin by SafariViewController
            self.naverConnection?.isInAppOauthEnable = true
            // NaverLogin screen direction - default: Portrait
            self.naverConnection?.setOnlyPortraitSupportInIphone(true)
        
            
            /// Login Default Setting
            // naverConnection.serviceUrlScheme = arguments[NaverLoginSdkConstant.Value.UrlScheme]
            self.naverConnection?.serviceUrlScheme = arguments![NaverLoginSdkConstant.Value.urlScheme]
            self.naverConnection?.consumerKey = arguments![NaverLoginSdkConstant.Value.clientId]
            self.naverConnection?.consumerSecret = arguments![NaverLoginSdkConstant.Value.clientSecret]
            self.naverConnection?.appName = arguments![NaverLoginSdkConstant.Value.clientName]
        }
    }
    
    /// Login and get AccessToken
    ///
    /// BackButton Pressed  --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    /// > open url:flutterNaverLogin://thirdPartyLoginResult?version=2&code=2
    /// > NaverLoginSdkDelegate.. oauthConnection 'didFailAuthorizationWithReceive' receiveType:THIRDPARTYLOGIN_RECEIVE_TYPE(rawValue: 2)
    ///
    /// UserCancel  --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    /// > open Url flutterNaverLogin://thirdPartyLoginResult?version=2&code=10
    /// > NaverLoginSdkDelegate.. oauthConnection 'didFailAuthorizationWithReceive' receiveType:THIRDPARTYLOGIN_RECEIVE_TYPE(rawValue: 10)
    ///
    /// Success --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    /// > url:flutterNaverLogin://thirdPartyLoginResult?version=2&code=0&authCode=rhEdoFKee0o5zlSpH3
    /// > NaverLoginSdkDelegate.. oauthConnection 'didFinishAuthorizationWithResult' receiveType:THIRDPARTYLOGIN_RECEIVE_TYPE(rawValue: 0)
    /// > NaverLoginSdkDelegate.. oauth20Connection 'DidFinishRequest' ACTokenWithAuthCode
    ///
    /// ReCall [authenticate] function when is Login State,
    /// > NaverLoginSdkDelegate.. oauth20Connection 'DidFinishRequest' ACTokenWithAuthCode
    func authenticate() {
        // naverConnection = NaverThirdPartyLoginConnection.getSharedInstance()
        if self.naverConnection != nil && self.naverConnection!.isPossibleToOpenNaverApp() {
            self.naverConnection?.requestThirdPartyLogin()
        } else {
            // AppStore NaverApp
            naverConnection?.openAppStoreForNaverApp()
        }
    }
    
    /// Remove Token client. (Some of)
    ///
    /// Called 'logout' when is not login > open url:flutterNaverLogin://thirdPartyLoginResult?version=2&code=1
    func logout() {
        // naverConnection = NaverThirdPartyLoginConnection.getSharedInstance()
        self.naverConnection?.resetToken()
    }
    
    /// Remove Token client and server. (All of)
    ///
    /// Called 'release' when is not login > open url:flutterNaverLogin://thirdPartyLoginResult?version=2&code=1
    ///
    /// Called [release] function when is login state
    /// > NaverLoginSdkDelegate.. oauth20Connection 'DidFinish' DeleteToken
    ///
    /// Recalled [release] function when is not login state
    /// > open url:flutterNaverLogin://thirdPartyLoginResult?version=2&code=1
    /// > NaverLoginSdkDelegate.. oauthConnection 'didFailAuthorizationWithReceive' receiveType:THIRDPARTYLOGIN_RECEIVE_TYPE(rawValue: 1)
    func release () {
        // naverConnection = NaverThirdPartyLoginConnection.getSharedInstance()
        self.naverConnection?.requestDeleteToken()
    }
    
    func profile() {
        if self.naverConnection != nil {
            let tokenType = naverConnection!.tokenType
            let accessToken = naverConnection!.accessToken
            let url = "https://openapi.naver.com/v1/nid/me"
        }
    }
    
    func getRefreshToken() {
        // naverConnection = NaverThirdPartyLoginConnection.getSharedInstance()
            // naverConnection.delegate = self
        self.naverConnection?.requestAccessTokenWithRefreshToken()
    }
}
