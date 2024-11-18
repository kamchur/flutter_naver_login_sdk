//
//  NaverLoginSdkDelegate.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/18/24.
//

import Foundation

extension NaverLoginSdkPlugin {
    /// Login Success after [authenticate]
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        <#code#>
    }
    
    /// Login Failure after [authenticate]
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
        <#code#>
    }
}
