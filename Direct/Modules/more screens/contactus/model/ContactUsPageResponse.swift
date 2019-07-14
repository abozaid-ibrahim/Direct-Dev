//
//  ContactUsPageResponse.swift
//  Direct
//
//  Created by abuzeid on 7/14/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import Foundation

// MARK: - ContactUsPageDataResponse
public struct ContactUsPageDataResponse: Codable {
    public let status: String?
    public let success: Int?
    public let values: Values?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case values = "values"
    }
    
    public init(status: String?, success: Int?, values: Values?) {
        self.status = status
        self.success = success
        self.values = values
    }
}

// MARK: - Values
public struct Values: Codable {
    public let chatTitle: String?
    public let contactNumber: String?
    public let emailDesc3: String?
    public let emailTitle3: String?
    public let emailDesc2: String?
    public let emailTitle2: String?
    public let emailDesc1: String?
    public let emailTitle1: String?
    public let timingsLine: String?
    
    enum CodingKeys: String, CodingKey {
        case chatTitle = "chat_title"
        case contactNumber = "contact_number"
        case emailDesc3 = "email_desc_3"
        case emailTitle3 = "email_title_3"
        case emailDesc2 = "email_desc_2"
        case emailTitle2 = "email_title_2"
        case emailDesc1 = "email_desc_1"
        case emailTitle1 = "email_title_1"
        case timingsLine = "timings_line"
    }
    
    public init(chatTitle: String?, contactNumber: String?, emailDesc3: String?, emailTitle3: String?, emailDesc2: String?, emailTitle2: String?, emailDesc1: String?, emailTitle1: String?, timingsLine: String?) {
        self.chatTitle = chatTitle
        self.contactNumber = contactNumber
        self.emailDesc3 = emailDesc3
        self.emailTitle3 = emailTitle3
        self.emailDesc2 = emailDesc2
        self.emailTitle2 = emailTitle2
        self.emailDesc1 = emailDesc1
        self.emailTitle1 = emailTitle1
        self.timingsLine = timingsLine
    }
}
