//
//  CompletedOrdersJsonResponse.swift
//  Direct
//
//  Created by abuzeid on 7/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
struct CompletedOrdersJsonResponse: Codable {
    public let completedVisa: [CompletedVisa]?
    
    enum CodingKeys: String, CodingKey {
        case completedVisa
    }
    
    public init(completedVisa: [CompletedVisa]?) {
        self.completedVisa = completedVisa
    }
}

// MARK: - CompletedVisa

public struct CompletedVisa: Codable {
    public let visaReqID: String?
    public let trackNo: String?
    public let visaStatusLog: [VisaStatusLog]?
    public let pendingDocs: [PendingDoc]?
    public let downloadDocs: [String]?
    public let paymentStatus: String?
    public let visaCountryID: String?
    public let paymentMethod: String?
    public let paymentChildMethod: String?
    public let total: String?
    public let byemailName: String?
    public let byemailAddress: String?
    public let byemailPhone: String?
    public let bybranch: String?
    public let status: String?
    
    enum CodingKeys: String, CodingKey {
        case visaReqID
        case trackNo
        case visaStatusLog
        case pendingDocs
        case downloadDocs
        case paymentStatus
        case visaCountryID
        case paymentMethod
        case paymentChildMethod
        case total
        case byemailName
        case byemailAddress
        case byemailPhone
        case bybranch
        case status
    }
    
    public init(visaReqID: String?, trackNo: String?, visaStatusLog: [VisaStatusLog]?, pendingDocs: [PendingDoc]?, downloadDocs: [String]?, paymentStatus: String?, visaCountryID: String?, paymentMethod: String?, paymentChildMethod: String?, total: String?, byemailName: String?, byemailAddress: String?, byemailPhone: String?, bybranch: String?, status: String?) {
        self.visaReqID = visaReqID
        self.trackNo = trackNo
        self.visaStatusLog = visaStatusLog
        self.pendingDocs = pendingDocs
        self.downloadDocs = downloadDocs
        self.paymentStatus = paymentStatus
        self.visaCountryID = visaCountryID
        self.paymentMethod = paymentMethod
        self.paymentChildMethod = paymentChildMethod
        self.total = total
        self.byemailName = byemailName
        self.byemailAddress = byemailAddress
        self.byemailPhone = byemailPhone
        self.bybranch = bybranch
        self.status = status
    }
}

// MARK: - PendingDoc

public struct PendingDoc: Codable {
    public let documentName: String?
    public let variableName: String?
    public let visaReqID: String?
    public let visaReqApplicantID: String?
    public let isSponser: Int?
    public let cid: String?
    public let documentFor: String?
    
    enum CodingKeys: String, CodingKey {
        case documentName
        case variableName
        case visaReqID
        case visaReqApplicantID
        case isSponser
        case cid
        case documentFor
    }
    
    public init(documentName: String?, variableName: String?, visaReqID: String?, visaReqApplicantID: String?, isSponser: Int?, cid: String?, documentFor: String?) {
        self.documentName = documentName
        self.variableName = variableName
        self.visaReqID = visaReqID
        self.visaReqApplicantID = visaReqApplicantID
        self.isSponser = isSponser
        self.cid = cid
        self.documentFor = documentFor
    }
}

// MARK: - VisaStatusLog

public struct VisaStatusLog: Codable {
    public let visaReqID: String?
    public let statusID: String?
    public let message: String?
    public let visaStatus: String?
    public let status: String?
    
    enum CodingKeys: String, CodingKey {
        case visaReqID
        case statusID
        case message
        case visaStatus
        case status
    }
    
    public init(visaReqID: String?, statusID: String?, message: String?, visaStatus: String?, status: String?) {
        self.visaReqID = visaReqID
        self.statusID = statusID
        self.message = message
        self.visaStatus = visaStatus
        self.status = status
    }
}
