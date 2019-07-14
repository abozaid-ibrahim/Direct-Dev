//
//  ContactUsFormParams.swift
//  Direct
//
//  Created by abuzeid on 7/14/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Foundation

// MARK: - ContactUsFormParams
public struct ContactUsFormParams: Codable {
    public let key: String?
    public let lang: String?
    public let name: String?
    public let email: String?
    public let mobile: String?
    public let subjectID: Int?
    public let trackNo: String?
    public let message: String?
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case lang = "lang"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case subjectID = "subject_id"
        case trackNo = "track_no"
        case message = "message"
    }
    
    public init(key: String?, lang: String?, name: String?, email: String?, mobile: String?, subjectID: Int?, trackNo: String?, message: String?) {
        self.key = key
        self.lang = lang
        self.name = name
        self.email = email
        self.mobile = mobile
        self.subjectID = subjectID
        self.trackNo = trackNo
        self.message = message
    }
}
