//
//  BranchesResponse.swift
//  Direct
//
//  Created by abuzeid on 7/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
// MARK: - BranchesResponse
public struct BranchesResponse: Codable {
    public let branch: [Branch]?
    
    enum CodingKeys: String, CodingKey {
        case branch = "Branch"
    }
    
    public init(branch: [Branch]?) {
        self.branch = branch
    }
}

// MARK: - Branch
public struct Branch: Codable {
    public let branchID: String?
    public let name: String?
    public let address: String?
    public let contactNo: String?
    public let bhours: String?
    public let lat: String?
    public let longt: String?
    public let url: String?
    public let status: String?
    public let success: String?
    
    enum CodingKeys: String, CodingKey {
        case branchID = "branch_id"
        case name = "name"
        case address = "address"
        case contactNo = "contact_no"
        case bhours = "bhours"
        case lat = "lat"
        case longt = "longt"
        case url = "url"
        case status = "status"
        case success = "success"
    }
    
    public init(branchID: String?, name: String?, address: String?, contactNo: String?, bhours: String?, lat: String?, longt: String?, url: String?, status: String?, success: String?) {
        self.branchID = branchID
        self.name = name
        self.address = address
        self.contactNo = contactNo
        self.bhours = bhours
        self.lat = lat
        self.longt = longt
        self.url = url
        self.status = status
        self.success = success
    }
}
