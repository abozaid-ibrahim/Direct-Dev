//
//  EligableSponserResponse.swift
//  Direct
//
//  Created by abuzeid on 6/23/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - EligableSponserResponse
class EligableSponserResponse: Codable {
    let sponsorOweners: [SponsorOwener]?
    
    enum CodingKeys: String, CodingKey {
        case sponsorOweners = "Sponsor Oweners"
    }
    
    init(sponsorOweners: [SponsorOwener]?) {
        self.sponsorOweners = sponsorOweners
    }
}

// MARK: - SponsorOwener
class SponsorOwener: Codable {
    let name, id, status, success: String?
    
    init(name: String?, id: String?, status: String?, success: String?) {
        self.name = name
        self.id = id
        self.status = status
        self.success = success
    }
}
