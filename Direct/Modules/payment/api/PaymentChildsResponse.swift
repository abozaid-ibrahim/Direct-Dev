//
//  PaymentChildsResponse.swift
//  Direct
//
//  Created by abuzeid on 6/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - PaymentChildsResponse
class PaymentChildsResponse: Codable {
    let paymentMethods: [ChildPaymentMethod]
    
    enum CodingKeys: String, CodingKey {
        case paymentMethods = "Payment Methods"
    }
    
    init(paymentMethods: [ChildPaymentMethod]) {
        self.paymentMethods = paymentMethods
    }
}

// MARK: - PaymentMethod
class ChildPaymentMethod: Codable {
    let id, paymentName, paymentMethodDescription, status: String
    let success: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case paymentName = "PaymentName"
        case paymentMethodDescription = "Description"
        case status, success
    }
    
    init(id: String, paymentName: String, paymentMethodDescription: String, status: String, success: String) {
        self.id = id
        self.paymentName = paymentName
        self.paymentMethodDescription = paymentMethodDescription
        self.status = status
        self.success = success
    }
}
