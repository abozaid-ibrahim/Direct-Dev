//
//  VisaAPIs.swift
//  Direct
//
//  Created by abuzeid on 5/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya

enum VisaAPIs {
    case visaRequest(prm: VisaRequestParams),
        visaRequirementForCountry(cid: String),
        getVisaPrice(prm: VisaPriceParams),
        applyToUS(USRequestParams),
        applyToUK(USRequestParams),
        getPreviousVisaType
}

extension VisaAPIs: TargetType {
    public var path: String {
        switch self {
        case .visaRequest:
            return "visa-request"
        case .visaRequirementForCountry:
            return "get-visa-requirement-page"
        case .getVisaPrice:
            return "get-visa-price"
        case .applyToUS:
            return "to-apply-us"
        case .getPreviousVisaType:
            return "get-previous-visa-type"
        case .applyToUK:
            return "to-apply-gb"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .visaRequest, .visaRequirementForCountry, .getVisaPrice, .applyToUK, .applyToUS, .getPreviousVisaType:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case let .visaRequest(prm):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "userid": 703,
                          "country_id": prm.country_id!,
                          "biometry_loc_id": prm.biometry_loc_id ?? "0",
                          "no_of_adult": prm.no_of_adult!,
                          "no_of_child": prm.no_of_child!,
                          "no_of_passport": prm.no_of_passport!,
                          "visatype": prm.visatype!,
                          "travel_date": prm.travel_date!,
                          "relation_with_travelers": prm.relation_with_travelers ?? "",
                          "request_source": "ios",
                          "request_source_comments": "iOS App 2.0 on iPhone 6 – iOS 11.4.0",
                          "promo_code": ""] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        case let .visaRequirementForCountry(cid):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "cid": cid] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        case let .getVisaPrice(prm):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "cid": prm.cid,
                          "cityid": prm.cityid,
                          "no_of_adult": prm.no_of_adult,
                          "no_of_child": prm.no_of_child,
                          "no_of_passport": prm.no_of_passport,
                          "visatype": prm.visatype,
                          "promo_code": ""] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        case let .applyToUS(req):
            let data = try! prmEncoder.encode(req)
            return .requestData(data)
        case let .applyToUK(req):
            let data = try! prmEncoder.encode(req)
            return .requestData(data)
        case .getPreviousVisaType:
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        }
    }

    public var validationType: ValidationType {
        switch self {
        case .visaRequest:
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
