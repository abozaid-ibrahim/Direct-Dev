//
//  VisaAPIs.swift
//  Direct
//
//  Created by abuzeid on 5/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya
import SwifterSwift
enum VisaAPIs {
    case visaRequest(prm: VisaRequestParams),
        visaRequirementForCountry(cid: String),
        getVisaPrice(prm: VisaPriceParams),
        applyToVisa(path: String, VisaRequirementsParams),
        getPreviousVisaType,
        getVisaReqRelation,
        getUSLivingRelatives,
        getPeriodOfPrevStay
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
        case .getPreviousVisaType:
            return "get-previous-visa-type"
        case let .applyToVisa(prm):
            return prm.path
        case .getVisaReqRelation:
            return "get-visa-req-relation"
        case .getUSLivingRelatives:
            return "get-us-living-relation"
        case .getPeriodOfPrevStay:
            return "get-period_of_prev_stay"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .visaRequest, .visaRequirementForCountry, .getVisaPrice, .applyToVisa, .getPreviousVisaType, .getVisaReqRelation, .getPeriodOfPrevStay, .getUSLivingRelatives:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case let .visaRequest(prm):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "userid": User.id,
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
        case let .applyToVisa(_, params):
            var dictionary: [String: Any] = ["key": tokenKeyValue]
            dictionary["lang"] = appLang
            dictionary["userid"] = User.id
            guard let pramsdic = try? params.asDictionary() else {
                return .requestParameters(parameters: dictionary, encoding: URLEncoding.default)
            }
            dictionary.merge(dict: pramsdic)
            let res = dictionary.compactMapValues { $0 }
            
            return .requestParameters(parameters: res, encoding: URLEncoding.default)
        case .getPreviousVisaType:
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        case .getVisaReqRelation:
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        case .getUSLivingRelatives:
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        case .getPeriodOfPrevStay:
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

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
