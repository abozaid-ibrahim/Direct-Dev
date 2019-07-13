//
//  UpdatePendingDocsParams.swift
//  Direct
//
//  Created by abuzeid on 7/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - UpdatePendingDocsParams

public struct UpdatePendingDocsParams: Codable {
    public let key: String?
    public let lang: String?
    public let visaReqID: Int?
    public let userid: String?
    public let transDate: String?
    public let transBank: Int?
    public let transAccName: String?
    public let transAmount: Int?

    enum CodingKeys: String, CodingKey {
        case key
        case lang
        case visaReqID = "visa_req_id"
        case userid
        case transDate = "trans_date"
        case transBank = "trans_bank"
        case transAccName = "trans_acc_name"
        case transAmount = "trans_amount"
    }

    public init(key: String?, lang: String?, visaReqID: Int?, userid: String?, transDate: String?, transBank: Int?, transAccName: String?, transAmount: Int?) {
        self.key = key
        self.lang = lang
        self.visaReqID = visaReqID
        self.userid = userid
        self.transDate = transDate
        self.transBank = transBank
        self.transAccName = transAccName
        self.transAmount = transAmount
    }
}
