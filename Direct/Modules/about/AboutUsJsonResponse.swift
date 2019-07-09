//
//  AboutUsJsonResponse.swift
//  Direct
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import Foundation

// MARK: - AboutUsResponse
public struct AboutUsResponse: Codable {
    public let aboutPage: [AboutPage]?
    
    enum CodingKeys: String, CodingKey {
        case aboutPage = "About Page"
    }
    
    public init(aboutPage: [AboutPage]?) {
        self.aboutPage = aboutPage
    }
}

// MARK: - AboutPage
public struct AboutPage: Codable {
    public let title: String?
    public let details: String?
    public let imageURL: String?
    public let status: String?
    public let success: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case details = "details"
        case imageURL = "image_url"
        case status = "status"
        case success = "success"
    }
    
    public init(title: String?, details: String?, imageURL: String?, status: String?, success: String?) {
        self.title = title
        self.details = details
        self.imageURL = imageURL
        self.status = status
        self.success = success
    }
}
