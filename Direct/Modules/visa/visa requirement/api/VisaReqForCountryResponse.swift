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
    let requirementPage: [RequirementPage]?
    
    enum CodingKeys: String, CodingKey {
        case requirementPage = "Requirement Page"
    }
    
    init(requirementPage: [RequirementPage]?) {
        self.requirementPage = requirementPage
    }
}

// MARK: - RequirementPage
class RequirementPage: Codable {
    let backgroundImageURL, flagURL: String?
    let requirements: [ReqInformation]?
    let backgroundImageUrl2: String?
    let countryID, name: String?
    let informations: [ReqInformation]?
    
    enum CodingKeys: String, CodingKey {
        case backgroundImageURL = "background_image_url"
        case flagURL = "flag_url"
        case requirements
        case backgroundImageUrl2 = "background_image_url2"
        case countryID = "country_id"
        case name, informations
    }
    
    init(backgroundImageURL: String?, flagURL: String?, requirements: [ReqInformation]?, backgroundImageUrl2: String?, countryID: String?, name: String?, informations: [ReqInformation]?) {
        self.backgroundImageURL = backgroundImageURL
        self.flagURL = flagURL
        self.requirements = requirements
        self.backgroundImageUrl2 = backgroundImageUrl2
        self.countryID = countryID
        self.name = name
        self.informations = informations
    }
}

// MARK: - Information
class ReqInformation: Codable {
    let isInfo, title: String?
    let icon: String?
    let image, desc: String?
    
    enum CodingKeys: String, CodingKey {
        case isInfo = "is_info"
        case title, icon, image, desc
    }
    
    init(isInfo: String?, title: String?, icon: String?, image: String?, desc: String?) {
        self.isInfo = isInfo
        self.title = title
        self.icon = icon
        self.image = image
        self.desc = desc
    }
}

