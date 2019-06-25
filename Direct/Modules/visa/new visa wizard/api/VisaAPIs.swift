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
        applyToVisa(path: String, USRequestParams),
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
        case let .applyToVisa(_, req):
            var dic1: [String: Any] = ["key": tokenKeyValue,
                                       "lang": appLang,
                                       "userid": 703,
                                       "visa_req_id": req.visaReqID ?? "",
                                       "visa_req_applicant_id": req.visaReqApplicantID ?? "",
                                       "first_name": req.firstName ?? "",
                                       "family_name": req.familyName ?? "",
                                       "mothers_first_name": req.mothersFirstName ?? "",
                                       "mothers_family_name": req.mothersFamilyName ?? "",
                                       "nationality": req.nationality ?? "",
                                       "passport_copy": req.passportCopy ?? "",
                                       "personal_photo_copy": req.personalPhotoCopy ?? ""]

            let dic2: [String: Any] = ["I_20_copy": req.universityAcceptanceImage ?? "",
                                       "ever_issued_visa": req.everIssuedVisaBefore ?? "",
                                       "previous_visa_copy": req.previousVisaCopy ?? "",
                                       "type_of_previous_visa": req.typeOfPreviousVisa ?? "",
                                       "date_of_issuing_previous_visa": req.dateOfArrival ?? "",//check
                                       "Place_of_issue_previous_visa": "",
                                       "travelled_before": req.travelledBeforeHere ?? "",
                                       "date_of_arrival": req.dateOfArrival ?? "",
                                       "period_of_previous_stay": req.periodOfPreviousStay ?? "",
                                       "have_driver_license": req.have_driver_license ?? "",
                                       "visa_cancelled_before": req.visa_cancelled_before ?? "",
                                       "before_visa_cancelled_reason": req.before_visa_cancelled_reason ?? "",
                                       "martial_status": req.martialStatus ?? "",
                                       "family_id_copy": req.familyIDCopy ?? "",
                                       "any_relatives_here": req.any_relatives_here ?? "",
                                       "relative_type": req.relative_type ?? "",
                                       "visits": req.visits ?? ""]
            dic1.merge(dic2, uniquingKeysWith: { _, new in new })

            return .requestParameters(parameters: dic1, encoding: URLEncoding.default)
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
