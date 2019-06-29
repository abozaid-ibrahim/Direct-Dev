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
        updatePaymentDetails(prm: SubmitPaymentParams),
        initPayfort(PayFortCredintials)
}

extension PaymentAPIs: TargetType {
    public var path: String {
        switch self {
        case .getAllParentPaymentMethod:
            return "get-master-payment-method"
        case .getChildsOfPayment:
            return "get-payment-method"
        case .updatePaymentDetails:
            return "update-payment-details"
        case .initPayfort(let cr):
            return cr.path

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
        case let .getChildsOfPayment(pid):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "pid": pid] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)

        case let .updatePaymentDetails(prm):
            var prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "parent_payment_id": prm.parent_payment_id ?? 0,
                          "child_payment_id": prm.child_payment_id ?? 0,
                          "online_payment_respose_code": prm.online_payment_respose_code ?? "",
                          "online_payment_respose_fortid": prm.online_payment_respose_fortid ?? ""] as [String: Any]
            let dic2 = ["online_payment_respose_msg": prm.online_payment_respose_msg ?? "",
                        "online_payment_respose_status": prm.online_payment_respose_status ?? "",
                        "payment_status": prm.payment_status ?? 0,
                        "reqid": prm.reqid ?? 0,
                        "userid": prm.userid ?? 0] as [String: Any]
            prmDic.merge(dic2, uniquingKeysWith: { _, new in new })
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        
        case .initPayfort(let  crd):
            return crd.task
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

