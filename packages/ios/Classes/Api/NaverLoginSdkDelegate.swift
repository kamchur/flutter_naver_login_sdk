//
//  NaverLoginSdkDelegate.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/20/24.
//

import Flutter
import Foundation
import NaverThirdPartyLogin

extension NaverLoginSdkPlugin {
    /// Login Success after [authenticate] function
    ///
    /// OAuth Success
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        // print("NaverLoginSdkDelegate.. oauth20Connection 'DidFinishRequest' ACTokenWithAuthCode")
        if self.sink != nil {
            if lastCallMethod == NaverLoginSdkConstant.Key.authenticate {
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess: nil])
            }
        }
    }
    
    /// Get RefreshToken after [getRefreshToken] function
    ///
    /// Refresh Success
    ///
    /// [authenticate] when is login state.
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        // print("NaverLoginSdkDelegate.. oauth20Connection 'DidFinishRequest' ACTokenWithRefreshToken")
        if self.sink != nil {
            switch self.lastCallMethod {
            case NaverLoginSdkConstant.Key.authenticate:
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess: nil])
            case NaverLoginSdkConstant.Key.refresh:
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess: nil])
            default:
                break
            }
        }
    }
    
    /// Remove Token only after [release] function
    ///
    /// Don't execute after [logout] function, you must remember it.
    ///
    ///
    /// ReCall [release] function when is released.
    /// > NaverLoginSdkPlugin.. open url:flutterNaverLogin://thirdPartyLoginResult?version=2&code=1
    /// > NaverLoginSdkDelegate.. oauthConnection 'didFailAuthorizationWithReceive' receiveType:THIRDPARTYLOGIN_RECEIVE_TYPE(rawValue: 1)
    public func oauth20ConnectionDidFinishDeleteToken() {
        // print("NaverLoginSdkDelegate.. oauth20Connection 'DidFinish' DeleteToken")
        if self.sink != nil {
            if lastCallMethod == NaverLoginSdkConstant.Key.release {
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess: nil])
            }
        }
    }
    
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
        // print("NaverLoginSdkDelegate.. oauth20Connection 'didFailWithError' : \(String(describing: error))")
        if self.sink != nil {
            switch self.lastCallMethod {
            case NaverLoginSdkConstant.Key.refresh:
                let httpStatus = error.asAFError?.responseCode ?? 401
                let message = error.localizedDescription
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure: [httpStatus, message]])
                break
            default:
                break
            }
        }
    }
    
    /// Login Fail Handler
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailAuthorizationWithReceive receiveType: THIRDPARTYLOGIN_RECEIVE_TYPE) {
        // print("NaverLoginSdkDelegate.. oauthConnection 'didFailAuthorizationWithReceive' receiveType:\(receiveType)")
        if self.sink != nil {
            switch self.lastCallMethod {
            case NaverLoginSdkConstant.Key.authenticate:
                // errorCode, message, 
                let errorCode = receiveType.rawValue
                let message = receiveLoginTypeConvert(rawValue: receiveType.rawValue)
                
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError: [errorCode, message]])
            case NaverLoginSdkConstant.Key.refresh:
                // errorCode, message
                let errorCode = receiveType.rawValue
                let message = receiveLoginTypeConvert(rawValue: receiveType.rawValue)
                
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError: [errorCode, message]])
            case NaverLoginSdkConstant.Key.release:
                // errorCode, message,
                // Android - onFailure
                let errorCode = receiveType.rawValue
                let message = receiveLoginTypeConvert(rawValue: receiveType.rawValue)
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError: [errorCode, message]])
            default:
                break
            }
        }
    }
    
    /// Login Success
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFinishAuthorizationWithResult receiveType: THIRDPARTYLOGIN_RECEIVE_TYPE) {
        // print("NaverLoginSdkDelegate.. oauthConnection 'didFinishAuthorizationWithResult' receiveType:\(receiveType)")
        switch self.lastCallMethod {
        case NaverLoginSdkConstant.Key.refresh:
            // httpStatus, message
            let httpStatus: String = String(receiveType.rawValue)
            let message: String = receiveLoginTypeConvert(rawValue: receiveType.rawValue)
            self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure: [httpStatus, message]])
        default:
            break
        }
    }
}
