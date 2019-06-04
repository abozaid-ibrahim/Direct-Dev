//
//  USVisaJsonResponse.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - USVvisaRequestJSONResponse
class USVvisaRequestJSONResponse: Codable {
    let applyGB: [ApplyGB]?
    
    enum CodingKeys: String, CodingKey {
        case applyGB = "Apply GB"
    }
    
    init(applyGB: [ApplyGB]?) {
        self.applyGB = applyGB
    }
}

// MARK: - ApplyGB
class ApplyGB: Codable {
    let status, success: String?
    
    init(status: String?, success: String?) {
        self.status = status
        self.success = success
    }
}
