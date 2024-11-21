//
//  NaverLoginSdkBridge.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/18/24.
//

import Foundation
import NaverThirdPartyLogin
import Alamofire

extension NaverLoginSdkPlugin: NaverLoginSdkProtocol {
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
    
    /// Success
    /// > oauth20ConnectionDidFinishRequestACTokenWithRefreshToken
    /// > NaverLoginSdkDelegate.. oauth20Connection 'DidFinishRequest' ACTokenWithRefreshToken
    ///
    /// Failure
    /// > didFailWithError
    /// > NaverLoginSdkDelegate.. oauth20Connection 'didFailWithError' : Optional(Error Domain=https://nid.naver.com Code=3 "invalid_request" UserInfo={NSLocalizedDescription=invalid_request})
    /// 
    /// When is not Login state.
    /// > NaverLoginSdkDelegate.. oauthConnection 'didFailAuthorizationWithReceive' receiveType:THIRDPARTYLOGIN_RECEIVE_TYPE(rawValue: 1)
    func refresh() {
        self.naverConnection?.requestAccessTokenWithRefreshToken()
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
    
    /// resultCode, message, response
    func profile() {
        if self.naverConnection != nil && self.naverConnection!.isValidAccessTokenExpireTimeNow(){
            guard let tokenType: String = naverConnection!.tokenType,
                  let accessToken: String = naverConnection!.accessToken else { return }
            guard let url = URL(string: "https://openapi.naver.com/v1/nid/me") else { return }
            
            let authroization = "\(tokenType) \(accessToken)"
            
            let request = AF.request(
                url,
                method: .get,
                parameters: nil,
                encoding: JSONEncoding.default,
                headers: ["Authorization": authroization]
            )
            
            request.responseDecodable(of: NaverUserProfile.self) { response in
                // guard let result = response.value as? [String: Any] else { return }
                // print("response:\(response)")
                // print("response.result:\(response.result)")
                switch response.result {
                case .success(let profile):
                    // print("success.. profile:\(profile)")
                    let resultCode = profile.resultcode
                    let message = profile.message
                    let response = profile.response
                    
                    do {
                        let encoder = JSONEncoder()
                        encoder.keyEncodingStrategy = .convertToSnakeCase       // keys
                        encoder.outputFormatting = .prettyPrinted       // JSON Formatting
                        
                        let jsonData = try encoder.encode(response)
                        // print("jsonData:\(jsonData)")
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            self.sink?([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess: [resultCode, message, jsonString]])
                        }
                    } catch {
                        self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure: [error.asAFError?.responseCode ?? 201, "\(error.localizedDescription)"]])
                    }
                case .failure(let error) :
                    self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure: [error.responseCode ?? 201, "\(error.localizedDescription)"]])
                }
            }
            
        } else {
            if self.sink != nil {
                self.sink!([NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure: [401, "Unauthorized"]])
            }
        }
    }
    
    func getVersion() -> String {
        return naverConnection?.getVersion() ?? "0"
    }
    
    func getTokenType() -> String? {
        return naverConnection?.tokenType
    }
    
    func getAccessToken() -> String? {
        return naverConnection?.accessToken
    }
    
    func getRefreshToken() -> String? {
        return naverConnection?.refreshToken
    }
    
    func getExpireAt() -> Date? {
        return naverConnection!.accessTokenExpireDate
    }
}
