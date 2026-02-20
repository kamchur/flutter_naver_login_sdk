//
//  NaverLoginSdkProtocol.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/20/24.
//

import Foundation

protocol NaverLoginSdkProtocol {
    func getVersion() -> String
    func getTokenType() -> String?
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
    func getExpireAt() -> Date?
}
