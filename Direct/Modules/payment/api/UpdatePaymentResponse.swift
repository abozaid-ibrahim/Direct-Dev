//
//  UpdatePaymentResponse.swift
//  Direct
//
//  Created by abuzeid on 6/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - UpdatePaymentResponse

class UpdatePaymentResponse: Codable {
    let updatePayment: [UpdatePayment]

    enum CodingKeys: String, CodingKey {
        case updatePayment = "Update_Payment"
    }

    init(updatePayment: [UpdatePayment]) {
        self.updatePayment = updatePayment
    }
}

// MARK: - UpdatePayment

class UpdatePayment: Codable {
    let trackNo: Int
    let status, success: String

    enum CodingKeys: String, CodingKey {
        case trackNo = "track_no"
        case status, success
    }

    init(trackNo: Int, status: String, success: String) {
        self.trackNo = trackNo
        self.status = status
        self.success = success
    }
}
