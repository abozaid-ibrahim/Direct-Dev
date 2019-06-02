//
//  AuthAPI.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 6/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya


enum AuthAPI {
    case login(id: String, password: String)
    case register
    case forgetPassword
}


extension AuthAPI: TargetType {
    var sampleData: Data {
        return "{no data handled, mock it if you need}".data(using: String.Encoding.utf8)!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .login(let id, let password):
            let params = [
                "username":id,
                "password":password,
                "key": APIConstant.Key.rawValue,
                "lang": "ar",
                "userDeviceId": UIDevice.current.identifierForVendor?.uuidString ?? "",
                "userDeviceType": "iOS"
                
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.httpBody)
        default:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
    
    var path: String {
        switch self {
        case .login:
            return "user-login"
        default:
            return ""
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
