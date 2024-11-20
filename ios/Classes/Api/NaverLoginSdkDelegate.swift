//
//  NaverLoginSdkDelegate.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/20/24.
//

import Foundation
import NaverThirdPartyLogin

extension NaverLoginSdkPlugin {
    /// Login Success after [authenticate] function
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("NaverLoginSdkDelegate.. oauth20Connection 'DidFinishRequest' ACTokenWithAuthCode")
    }
    
    /// Get RefreshToken after [getRefreshToken] function
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("NaverLoginSdkDelegate.. oauth20Connection 'DidFinishRequest' ACTokenWithRefreshToken")
    }
    
    /// Remove Token only after [release] function
    ///
    /// Don't execute after [logout] function, you must remember it.
    public func oauth20ConnectionDidFinishDeleteToken() {
        print("NaverLoginSdkDelegate.. oauth20Connection 'DidFinish' DeleteToken")
    }
    
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
        print("NaverLoginSdkDelegate.. oauth20Connection 'didFailWithError' : \(String(describing: error))")
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailAuthorizationWithReceive receiveType: THIRDPARTYLOGIN_RECEIVE_TYPE) {
        print("NaverLoginSdkDelegate.. oauthConnection 'didFailAuthorizationWithReceive' receiveType:\(receiveType)")
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFinishAuthorizationWithResult receiveType: THIRDPARTYLOGIN_RECEIVE_TYPE) {
        print("NaverLoginSdkDelegate.. oauthConnection 'didFinishAuthorizationWithResult' receiveType:\(receiveType)")
    }
}
