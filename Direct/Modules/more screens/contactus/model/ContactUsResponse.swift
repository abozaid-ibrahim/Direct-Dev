//
//  ContactUsResponse.swift
//  Direct
//
//  Created by abuzeid on 7/14/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contactUsFormResponse = try? newJSONDecoder().decode(ContactUsFormResponse.self, from: jsonData)

import Foundation

// MARK: - ContactUsFormResponse
public struct ContactUsFormResponse: Codable {
    public let contactUs: [ContactUs]?
    
    enum CodingKeys: String, CodingKey {
        case contactUs = "Contact Us"
    }
    
    public init(contactUs: [ContactUs]?) {
        self.contactUs = contactUs
    }
}

// MARK: - ContactUs
public struct ContactUs: Codable {
    public let status: String?
    public let success: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
    }
    
    public init(status: String?, success: String?) {
        self.status = status
        self.success = success
    }
}
