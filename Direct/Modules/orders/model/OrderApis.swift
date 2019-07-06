
//
//  OrdersApi.swift
//  Direct
//
//  Created by abuzeid on 7/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya

enum OrdersAPIs {
    case getCompletedVisa(trackNo: String)
}

extension OrdersAPIs: TargetType {
    public var path: String {
        switch self {
        case .getCompletedVisa:
            return "get-completed-visa"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getCompletedVisa:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case let .getCompletedVisa(trNo):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "userid": User.id,
                          "track_no": trNo] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        case .getCompletedVisa:
            return .successCodes
        default:
            return .none
        }
    }
    
    public var sampleData: Data {
        return "{no data handled, mock it if you need}".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}



