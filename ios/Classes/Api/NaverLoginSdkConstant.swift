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
        static let profile: String = "profile"
    }
    
    struct Value {
        static let urlScheme: String = "urlScheme"
        static let clientId: String = "clientId"
        static let clientSecret: String = "clientSecret"
        static let clientName: String = "clientName"
    }
}
