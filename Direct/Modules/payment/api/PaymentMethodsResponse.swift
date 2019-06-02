//
//  PaymentMethodsResponse.swift
//  Direct
//
//  Created by abuzeid on 6/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
// MARK: - PaymentMethodsResponse
class PaymentMethodsResponse: Codable {
    let paymentMethods: [PaymentMethod]?
    
    enum CodingKeys: String, CodingKey {
        case paymentMethods = "Payment Methods"
    }
    
    init(paymentMethods: [PaymentMethod]?) {
        self.paymentMethods = paymentMethods
    }
}

// MARK: - PaymentMethod
class PaymentMethod: Codable {
    let id, paymentName, status, success: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case paymentName = "PaymentName"
        case status, success
    }
    
    init(id: String, paymentName: String, status: String, success: String) {
        self.id = id
        self.paymentName = paymentName
        self.status = status
        self.success = success
    }
}
