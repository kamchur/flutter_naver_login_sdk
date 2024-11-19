//
//  NaverLoginSdkDelegate.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/18/24.
//

import Foundation
import NaverThirdPartyLogin

extension NaverLoginSdkPlugin {
    /// 2024-11-19-Tue.
    /// Login State
    ///
    /// SUCCESS
    /// PARAMETERNOTSET: Not setting parameters.
    /// CANCELBYUSER
    /// NAVERRAPPNOTINSTALLED: SafariViewController disable and Not Installed Naver App
    /// NAVERAPPVERSIONINVALID: SafariViewController disable and Installed Naver App but bad version.
    /// OAUTHMETHODNOTSET: ALL NOT ACCESS
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("NaverLoginSdkDelegate.. application.. openUrl:\(url)")
        return NaverThirdPartyLoginConnection.getSharedInstance().application(application, open: url, options: options)
    }
    
    
    /// Login 'Success' after [authenticate] function.
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("NaverLoginSdkDelegate.. oauth20ConnectionDidFinishRequestACTokenWithAuthCode..")
    }
    
    /// Login 'Failure' after [authenticate] function.
    /// Refresh Token 'Failure' after [requestAccessTokenWithRefreshToken] function.
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
        print("NaverLoginSdkDelegate.. oauthConnection.. didFatilWithError:\(error)")
    }
    
    /// Refresh Token 'Success' after [requestAccessTokenWithRefreshToken] function.
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("NaverLoginSdkDelegate.. oauth20ConnectionDidFinishRequestACTokenWithRefreshToken...")
    }
    
    public func oauth20ConnectionDidFinishDeleteToken() {
        print("")
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailAuthorizationWithReceive receiveType: THIRDPARTYLOGIN_RECEIVE_TYPE) {
        print("NaverLoginSdkDelegate.. oauth20Connection.. didFailAuthorizationWithReceive..:\(receiveType.rawValue)")
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFinishAuthorizationWithResult receiveType: THIRDPARTYLOGIN_RECEIVE_TYPE) {
        print("NaverLoginSdkDelegate.. oauth20Connection.. didFinishAuthorizationWithResult..")
    }
}
