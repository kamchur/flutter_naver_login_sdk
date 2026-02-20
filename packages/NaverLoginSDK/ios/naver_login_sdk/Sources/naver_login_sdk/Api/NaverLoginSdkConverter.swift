//
//  NaverLoginSdkConverter.swift
//  naver_login_sdk
//
//  Created by Lagerstroemia-Indica on 11/20/24.
//

import Foundation

extension NaverLoginSdkPlugin {
    func receiveLoginTypeConvert(rawValue value: UInt32) -> String {
        var result: String
        result = switch value {
        case 0:
            "SUCCESS"
        case 1:
            "PARAMETERNOTSET"
        case 2:
            "CANCELBYUSER"
        case 3:
            "NAVERAPPNOTINSTALLED"
        case 4:
            "NAVERAPPVERSIONINVALID"
        case 5:
            "OAUTHMETHODNOTSET"
        case 6:
            "INVALIDREQUEST"
        case 7:
            "CLIENTNETWORKPROBLEM"
        case 8:
            "UNAUTHORIZEDCLIENT"
        case 9:
            "UNSUPPORTEDRESPONSETYPE"
        case 10:
            "NETWORKERROR"
        default:
            // 11
            "UNKNOWNERROR"
        }
        return result
    }
}
