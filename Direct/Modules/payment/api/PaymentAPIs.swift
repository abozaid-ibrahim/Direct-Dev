//
//  PaymentAPIs.swift
//  Direct
//
//  Created by abuzeid on 6/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import Foundation
import Moya

enum PaymentAPIs {
    case getAllParentPaymentMethod,
        getChildsOfPayment(cid: String),
        updatePaymentDetails(prm: String)
}

extension PaymentAPIs: TargetType {
    public var path: String {
        switch self {
        case .getAllParentPaymentMethod:
            return "get-master-payment-method"
        case .getChildsOfPayment(let pid):
            return "get-payment-method"
        case .updatePaymentDetails(let prm):
            return "update-payment-details"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var task: Task {
        switch self {
        case .getAllParentPaymentMethod:
            
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "promo_code": ""] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        case .getChildsOfPayment(let pid):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "pid": pid] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
            
        case .updatePaymentDetails(let prm):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "promo_code": ""] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        return .none
    }
    
    public var sampleData: Data {
        return "{no data handled, mock it if you need}".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}

//
