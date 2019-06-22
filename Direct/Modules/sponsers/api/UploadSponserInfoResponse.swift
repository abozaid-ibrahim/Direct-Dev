//
//  UploadSponserInfoResponse.swift
//  Direct
//
//  Created by abuzeid on 6/23/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class UploadSponserInfoResponse: Codable {
    let applySponsor: [ApplySponsor]?
    
    enum CodingKeys: String, CodingKey {
        case applySponsor = "Apply Sponsor"
    }
    
    init(applySponsor: [ApplySponsor]?) {
        self.applySponsor = applySponsor
    }
}

// MARK: - ApplySponsor
class ApplySponsor: Codable {
    let status, success: String?
    
    init(status: String?, success: String?) {
        self.status = status
        self.success = success
    }
}
