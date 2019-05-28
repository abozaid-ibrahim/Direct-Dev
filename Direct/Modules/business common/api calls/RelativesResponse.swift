//
//  RelativesResponse.swift
//  Direct
//
//  Created by abuzeid on 5/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - RelativesResponse
class RelativesResponse: Codable {
    let relatives: [Relative]
    
    enum CodingKeys: String, CodingKey {
        case relatives = "Relatives"
    }
    
    init(relatives: [Relative]) {
        self.relatives = relatives
    }
}

// MARK: - Relative
class Relative: Codable {
    let id, name, status, success: String
    
    init(id: String, name: String, status: String, success: String) {
        self.id = id
        self.name = name
        self.status = status
        self.success = success
    }
}
