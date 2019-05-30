//
//  VisaReqForCountryResponse.swift
//  Direct
//
//  Created by abuzeid on 5/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - VisaRequirementForCountryResponse
class VisaRequirementForCountryResponse: Codable {
    let requirementPage: [RequirementPage]
    
    enum CodingKeys: String, CodingKey {
        case requirementPage = "Requirement Page"
    }
    
    init(requirementPage: [RequirementPage]) {
        self.requirementPage = requirementPage
    }
}

// MARK: - RequirementPage
class RequirementPage: Codable {
    let flagURL, backgroundImageURL: String
    let backgroundImageUrl2: String
    let name, countryID: String
    let requirements: [Requirement]
    
    enum CodingKeys: String, CodingKey {
        case flagURL = "flag_url"
        case backgroundImageURL = "background_image_url"
        case backgroundImageUrl2 = "background_image_url2"
        case name
        case countryID = "country_id"
        case requirements
    }
    
    init(flagURL: String, backgroundImageURL: String, backgroundImageUrl2: String, name: String, countryID: String, requirements: [Requirement]) {
        self.flagURL = flagURL
        self.backgroundImageURL = backgroundImageURL
        self.backgroundImageUrl2 = backgroundImageUrl2
        self.name = name
        self.countryID = countryID
        self.requirements = requirements
    }
}

// MARK: - Requirement
class Requirement: Codable {
    let title, desc: String
    let image, icon: String
    let isInfo: String
    
    enum CodingKeys: String, CodingKey {
        case title, desc, image, icon
        case isInfo = "is_info"
    }
    
    init(title: String, desc: String, image: String, icon: String, isInfo: String) {
        self.title = title
        self.desc = desc
        self.image = image
        self.icon = icon
        self.isInfo = isInfo
    }
}
