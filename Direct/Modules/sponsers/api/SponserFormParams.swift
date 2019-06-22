//
//  SponserFormParams.swift
//  Direct
//
//  Created by abuzeid on 6/23/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class SponserFormParams: Codable {
    let key, lang: String?
    let userid, visaReqID, sponserNo, ownerOfBankStmt: Int?
    let someoneElse: Int?
    let someoneElseAttachment, bankStmtAttachment, jobLetterAttachment: String?
    
    enum CodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqID = "visa_req_id"
        case sponserNo = "sponser_no"
        case ownerOfBankStmt = "owner_of_bank_stmt"
        case someoneElse = "someone_else"
        case someoneElseAttachment = "someone_else_attachment"
        case bankStmtAttachment = "bank_stmt_attachment"
        case jobLetterAttachment = "job_letter_attachment"
    }
    
    init(key: String?, lang: String?, userid: Int?, visaReqID: Int?, sponserNo: Int?, ownerOfBankStmt: Int?, someoneElse: Int?, someoneElseAttachment: String?, bankStmtAttachment: String?, jobLetterAttachment: String?) {
        self.key = key
        self.lang = lang
        self.userid = userid
        self.visaReqID = visaReqID
        self.sponserNo = sponserNo
        self.ownerOfBankStmt = ownerOfBankStmt
        self.someoneElse = someoneElse
        self.someoneElseAttachment = someoneElseAttachment
        self.bankStmtAttachment = bankStmtAttachment
        self.jobLetterAttachment = jobLetterAttachment
    }
}
