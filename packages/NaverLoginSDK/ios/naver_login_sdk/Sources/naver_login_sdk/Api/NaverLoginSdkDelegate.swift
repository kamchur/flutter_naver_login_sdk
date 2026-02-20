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
                
                // 2026-02-20-Fri, flutterResult return true value when called onSuccess event.
                if self.flutterResult != nil {
                    self.flutterResult!(true)
                    
                }
            }
        }
        // 2026-02-20-Fri, flutterResult clear.
        self.flutterResult = nil
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
                
                // 2026-02-20-Fri, authenticate return true value.
                if self.flutterResult != nil {
                    self.flutterResult!(true)
                }
                break
            case NaverLoginSdkConstant.Key.refresh:
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess: nil])
                
                // 2026-02-20-Fri, refresh return true value,
                if self.flutterResult != nil {
                    self.flutterResult!(true)
                }
                break
            default:
                break
            }
        }
        
        // 2026-02-20-Fri, flutterResult clear.
        self.flutterResult = nil
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
                
                // 2026-02-20-Fri, release function return true value, when it called onSuccess event.
                if self.flutterResult != nil {
                    self.flutterResult!(true)
                }
            }
        }
        
        // 2026-02-20-Fri, flutterResult clear
        self.flutterResult = nil
    }
    
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
        // print("NaverLoginSdkDelegate.. oauth20Connection 'didFailWithError' : \(String(describing: error))")
        if self.sink != nil {
            switch self.lastCallMethod {
            case NaverLoginSdkConstant.Key.authenticate:
                // (error as NSError).code
                let errorCode = (error as NSError).code
                let message = error.localizedDescription
                
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError: [errorCode, message]])
                
                // 2026-02-20-Fri, authenticate return false value when it called onError event.
                if self.flutterResult != nil {
                    flutterResult!(false)
                }
                break
            case NaverLoginSdkConstant.Key.refresh:
                // let httpStatus = String(error.asAFError?.responseCode ?? 401)
                let errorCode = (error as NSError).code
                let message = error.localizedDescription
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError: [errorCode, message]])
                
                // 2026-02-20-Fri, refresh function return false value, when it called onError.
                if self.flutterResult != nil {
                    self.flutterResult!(false)
                }
                break
            default:
                break
            }
        }
        
        // 2026-02-20-Fri, flutterResult clear
        self.flutterResult = nil
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
                
                // 2026-02-20-Fri, authenticate return false value, when it called onError event.
                if self.flutterResult != nil {
                    self.flutterResult!(false)
                }
                break
            case NaverLoginSdkConstant.Key.refresh:
                // errorCode, message
                let errorCode = receiveType.rawValue
                let message = receiveLoginTypeConvert(rawValue: receiveType.rawValue)
                
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError: [errorCode, message]])
                
                // 2026-02-20-Fri, refresh function return false value, when it called onError event.
                if self.flutterResult != nil {
                    self.flutterResult!(false)
                }
                break
            case NaverLoginSdkConstant.Key.release:
                // errorCode, message,
                // Android - onFailure
                let errorCode = receiveType.rawValue
                let message = receiveLoginTypeConvert(rawValue: receiveType.rawValue)
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError: [errorCode, message]])
                
                // 2026-02-20-Fri, release function return false value, when it called onError event.
                if self.flutterResult != nil {
                    self.flutterResult!(false)
                }
                break
            default:
                break
            }
        }
        
        // 2026-02-20-Fri, flutterResult clear
        self.flutterResult = nil
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
            
            // 2026-02-20-Fri, refreash function return false value, when it called onFailure event.
            if self.flutterResult != nil {
                self.flutterResult!(false)
            }
            break
        default:
            break
        }
        
        // 2026-02-20-Fri, flutterResult clear
        self.flutterResult = nil
    }
}
