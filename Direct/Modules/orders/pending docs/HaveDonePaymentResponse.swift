//
//  HaveDonePaymentResponse.swift
//  Direct
//
//  Created by abuzeid on 7/12/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Foundation

// MARK: - UpdatePendingDocsResponse
public struct HaveDonePaymentResponse: Codable {
    public let haveDonePayment: HaveDonePayment?
    
    enum CodingKeys: String, CodingKey {
        case haveDonePayment = "Have Done Payment"
    }
    
    public init(haveDonePayment: HaveDonePayment?) {
        self.haveDonePayment = haveDonePayment
    }
}

// MARK: - HaveDonePayment
public struct HaveDonePayment: Codable {
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
