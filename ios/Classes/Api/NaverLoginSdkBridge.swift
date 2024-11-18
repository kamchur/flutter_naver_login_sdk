//
//  NaverLoginSdkBridge.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/18/24.
//

import Foundation
import NaverThirdPartyLogin

extension NaverLoginSdkPlugin: NaverThirdPartyLoginConnectionDelegate {
    func initialize(args arguments: [String: String]?) {
        if arguments != nil {
            // print("NaverLoginSdkBridge.. arguments:\(arguments)")
            if let naverConnection = NaverThirdPartyLoginConnection.getSharedInstance() {
                // NaverLogin into NaverApplication
                naverConnection.isNaverAppOauthEnable = true
                // NaverLogin by SafariViewController
                naverConnection.isInAppOauthEnable = true
                // NaverLogin screen direction - default: Portrait
                naverConnection.setOnlyPortraitSupportInIphone(true)
                
                /// Login Default Setting
                // naverConnection.serviceUrlScheme = arguments[NaverLoginSdkConstant.Value.UrlScheme]
                naverConnection.consumerKey = arguments![NaverLoginSdkConstant.Value.clientId]
                naverConnection.consumerSecret = arguments![NaverLoginSdkConstant.Value.clientSecret]
                naverConnection.appName = arguments![NaverLoginSdkConstant.Value.clientName]
            }
        }
    }
    
    /// Login and get AccessToken
    func authenticate() {
        if let naverConnection = NaverThirdPartyLoginConnection.getSharedInstance() {
            naverConnection.delegate = self
            naverConnection.requestThirdPartyLogin()
        }
    }
}
