//
//  BioChoicesResponse.swift
//  Direct
//
//  Created by abuzeid on 5/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - BioChoicesResponse
class BioChoicesResponse: Codable {
    let bioOption: [BioOption]
    
    enum CodingKeys: String, CodingKey {
        case bioOption = "Bio-Option"
    }
    
    init(bioOption: [BioOption]) {
        self.bioOption = bioOption
    }
}

// MARK: - BioOption
class BioOption: Codable {
    let id, name, status, success: String
    
    init(id: String, name: String, status: String, success: String) {
        self.id = id
        self.name = name
        self.status = status
        self.success = success
    }
}
