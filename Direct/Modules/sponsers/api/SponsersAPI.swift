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
    case uploadSponserForm(prm: SponserFormParams)
}

extension SponsersAPIs: TargetType {
    public var path: String {
        switch self {
        case .uploadSponserForm:
            return "to-apply-sponsor"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .uploadSponserForm:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .uploadSponserForm(let prm):
            let prmDic = ["key": tokenKeyValue,
                          "lang": appLang,
                          "userid": 73,
                          "visa_req_id": prm.visaReqID ?? 0,
                          "sponser_no": prm.sponserNo ?? 0,
                          "owner_of_bank_stmt": prm.ownerOfBankStmt ?? 0,
                          "someone_else": prm.someoneElse ?? 0,
                          "someone_else_attachment": prm.someoneElseAttachment ?? "",
                          "bank_stmt_attachment": prm.bankStmtAttachment ?? "",
                          "job_letter_attachment": prm.jobLetterAttachment ?? ""] as [String: Any]
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
