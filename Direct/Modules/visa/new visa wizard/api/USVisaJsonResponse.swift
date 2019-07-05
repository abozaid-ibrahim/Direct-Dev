//
//  USVisaJsonResponse.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - USVvisaRequestJSONResponse

enum USVvisaRequestCodingKeys: String, CodingKey, CaseIterable {
    case applyUS = "Apply US"
    case applySGN = "Apply SGN"
    case applyGB = "Apply GB"
    case applyIN = "Apply IN"
    case applyCN = "Apply CN"
    case applyJP = "Apply JP"
    case applyIE = "Apply IE"
    case applyTR = "Apply TR"
}

struct USVvisaRequestJSONResponse: Codable {
    let data: ApplyiedCountryResponse?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: USVvisaRequestCodingKeys.self)
        let value = USVvisaRequestCodingKeys.allCases.compactMap { key in
            try? container.decode([ApplyiedCountryResponse].self, forKey: key)
        }
        data = value.first?.first
    }
}

// MARK: - ApplyGB

class ApplyiedCountryResponse: Codable {
    let status, success: String?

    init(status: String?, success: String?) {
        self.status = status
        self.success = success
    }
}
