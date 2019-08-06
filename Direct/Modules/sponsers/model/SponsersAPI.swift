//
//  SponsersAPI.swift
//  Direct
//
//  Created by abuzeid on 6/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya

enum SponsersAPIs {
    case uploadSponserForm(prm: SponserFormParams),
        getSponserOwner(userid: String, reqid: String, cid: String)
}

extension SponsersAPIs: TargetType {
    public var path: String {
        switch self {
        case .uploadSponserForm:
            return "to-apply-sponsor"
        case .getSponserOwner:
            return "get-sponser-owner"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .uploadSponserForm, .getSponserOwner:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .uploadSponserForm(let prm):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "userid": User.shared.id,
                          "visa_req_id": prm.visaReqID ?? 0,
                          "sponser_no": prm.sponserNo ?? 0,
                          "owner_of_bank_stmt": prm.ownerOfBankStmt ?? 0,
                          "someone_else": prm.someoneElse ?? 0,
                          "someone_else_attachment": prm.someoneElseAttachment ?? "",
                          "bank_stmt_attachment": prm.bankStmtAttachment ?? "",
                          "job_letter_attachment": prm.jobLetterAttachment ?? ""] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
            
        case .getSponserOwner(let prm):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "userid": User.shared.id,
                          "reqid": prm.reqid,
                          "cid": prm.cid] as [String: Any]
            return .requestParameters(parameters: prmDic, encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        case .uploadSponserForm:
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
