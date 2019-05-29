//
//  VisaAPIs.swift
//  Direct
//
//  Created by abuzeid on 5/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya
public class VisaRequestParams {
    var userid: String!,
        country_id: String!,
        biometry_loc_id: String!,
        no_of_adult: String!,
        no_of_child: String!,
        no_of_passport: String!,
        visatype: String!,
        travel_date: String!,
        relation_with_travelers: String!,
        request_source: String!,
        request_source_comments: String!,
        promo_code: String!
}

public enum VisaAPIs {
    case visaRequest(prm: VisaRequestParams)
}

extension VisaAPIs: TargetType {
    public var path: String {
        switch self {
        case .visaRequest:
            return "visa-request"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .visaRequest:
            return .post
        default:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case let .visaRequest(prm):
            let prmDic = ["key": "bf930e30-8c28-42d6-bf8e-f4cbd0b83774",
                          "lang": "en",
                          "userid": 703,
                          "country_id": prm.country_id,
                          "biometry_loc_id": prm.biometry_loc_id,
                          "no_of_adult": prm.no_of_adult,
                          "no_of_child": prm.no_of_child,
                          "no_of_passport": prm.no_of_passport,
                          "visatype": prm.visatype,
                          "travel_date": prm.travel_date,
                          "relation_with_travelers": prm.relation_with_travelers,
                          "request_source": "ios",
                          "request_source_comments": "iOS App 2.0 on iPhone 6 – iOS 11.4.0",
                          "promo_code": ""] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: ["key": "bf930e30-8c28-42d6-bf8e-f4cbd0b83774", "lang": "en"], encoding: URLEncoding.default)
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
