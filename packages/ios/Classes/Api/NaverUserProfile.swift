//
//  NaverUserProfile.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/20/24.
//

import Foundation

struct NaverUserProfile: Codable {
    let resultcode: String
    let message: String
    let response: ResponseData
    
    struct ResponseData: Codable {
        let id: String?
        let nickname: String?
        let name: String?
        let email: String?
        let gender: String?
        let age: String?
        let birthday: String?
        let profileImage: String?
        let birthyear: String?
        let mobile: String?
        let ci: String?
        let encId: String?
    }
}
