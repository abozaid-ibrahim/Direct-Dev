//
//  VisaRelationsJsonResponse.swift
//  Direct
//
//  Created by abuzeid on 6/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - VisaRelationsJSONResponse
class VisaRelationsJSONResponse: Codable {
    let usRelatives: [USRelative]?
    
    enum CodingKeys: String, CodingKey {
        case usRelatives = "US Relatives"
    }
    
    init(usRelatives: [USRelative]?) {
        self.usRelatives = usRelatives
    }
}

// MARK: - USRelative
class USRelative: Codable {
    let id, name: String?
    let icon, icon2: String?
    let status, success: String?
    
    init(id: String?, name: String?, icon: String?, icon2: String?, status: String?, success: String?) {
        self.id = id
        self.name = name
        self.icon = icon
        self.icon2 = icon2
        self.status = status
        self.success = success
    }
}
