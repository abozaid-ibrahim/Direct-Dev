//
//  SubmitPaymentOptionsResponse.swift
//  Direct
//
//  Created by abuzeid on 6/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class SubmitPaymentParams: Codable {
    var online_payment_respose_code,
        online_payment_respose_fortid,
        online_payment_respose_msg,
        online_payment_respose_status: String?
    var parent_payment_id, child_payment_id, payment_status,
        reqid,
        userid: Int?

    init() {
        online_payment_respose_code = nil
        online_payment_respose_fortid = nil
        online_payment_respose_msg = nil
        online_payment_respose_status = nil
        parent_payment_id = nil
        child_payment_id = nil
        payment_status = nil
        reqid = nil
        userid = nil
    }
}
