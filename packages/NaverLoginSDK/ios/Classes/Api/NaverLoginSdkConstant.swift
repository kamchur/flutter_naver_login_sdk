//
//  NaverLoginSdkConstant.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia on 11/17/24.
//

import Foundation

struct NaverLoginSdkConstant {
    static let channelNameMethod: String = "naver_login_sdk_method"
    static let channelNameEvent: String = "naver_login_sdk_event"
    
    struct Key {
        static let initialize: String  = "initialize"
        static let authenticate: String = "authenticate"
        static let logout: String = "logout"
        static let release: String = "release"
        static let profile: String = "profile"
        static let refresh: String = "refresh"
        
        static let version: String = "version"
        static let tokenType: String = "tokenType"
        static let acessToken: String = "accessToken"
        static let refreshToken: String = "refreshToken"
        static let expireAt: String = "expireAt"
        
        struct NaverLoginEventCallback {
            static let onSuccess: String = "onSuccess"
            static let onFailure: String = "onFailure"
            static let onError: String = "onError"
        }
    }
    
    struct Value {
        static let urlScheme: String = "urlScheme"
        static let clientId: String = "clientId"
        static let clientSecret: String = "clientSecret"
        static let clientName: String = "clientName"
    }
}
