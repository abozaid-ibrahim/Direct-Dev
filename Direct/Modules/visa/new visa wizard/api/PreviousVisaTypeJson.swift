//
//  PreviousVisaTypeJson.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class PreviousVisaTypeJSONResponse: Codable {
    let previousVisaType: [PreviousVisaType]?

    enum CodingKeys: String, CodingKey {
        case previousVisaType = "Previous Visa Type"
    }

    init(previousVisaType: [PreviousVisaType]?) {
        self.previousVisaType = previousVisaType
    }
}

// MARK: - PreviousVisaType

class PreviousVisaType: Codable {
    let id, name, status, success: String?

    init(id: String?, name: String?, status: String?, success: String?) {
        self.id = id
        self.name = name
        self.status = status
        self.success = success
    }
}
