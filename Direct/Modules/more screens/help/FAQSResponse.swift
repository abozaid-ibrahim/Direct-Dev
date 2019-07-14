//
//  FAQSResponse.swift
//  Direct
//
//  Created by abuzeid on 7/14/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - ContactUsResponse
public struct FaqsResponse: Codable {
    public let faqPage: [FAQPage]?
    
    enum CodingKeys: String, CodingKey {
        case faqPage = "Faq Page"
    }
    
    public init(faqPage: [FAQPage]?) {
        self.faqPage = faqPage
    }
}

// MARK: - FAQPage
public struct FAQPage: Codable {
    public let category: String?
    public let details: [Detail]?
    public let status: String?
    public let success: String?
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case details = "details"
        case status = "status"
        case success = "success"
    }
    
    public init(category: String?, details: [Detail]?, status: String?, success: String?) {
        self.category = category
        self.details = details
        self.status = status
        self.success = success
    }
}

// MARK: - Detail
public struct Detail: Codable {
    public let question: String?
    public let answare: String?
    public let status: String?
    public let success: String?
    
    enum CodingKeys: String, CodingKey {
        case question = "question"
        case answare = "answare"
        case status = "status"
        case success = "success"
    }
    
    public init(question: String?, answare: String?, status: String?, success: String?) {
        self.question = question
        self.answare = answare
        self.status = status
        self.success = success
    }
}
