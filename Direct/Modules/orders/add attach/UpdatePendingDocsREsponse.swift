//
//  UpdatePendingDocsREsponse.swift
//  Direct
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Foundation

// MARK: - UpdatePendingDocsResponse
public struct UpdatePendingDocsResponse: Codable {
    public let updateMissingDocuments: UpdateMissingDocuments?
    
    enum CodingKeys: String, CodingKey {
        case updateMissingDocuments = "Update Missing Documents"
    }
    
    public init(updateMissingDocuments: UpdateMissingDocuments?) {
        self.updateMissingDocuments = updateMissingDocuments
    }
}

// MARK: - UpdateMissingDocuments
public struct UpdateMissingDocuments: Codable {
    public let status: String?
    public let success: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
    }
    
    public init(status: String?, success: String?) {
        self.status = status
        self.success = success
    }
}
