//
//  VisaPriceResponse.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - VisaPriceResponse
class VisaPriceResponse: Codable {
    let visaPrice: [VisaPrice]
    
    enum CodingKeys: String, CodingKey {
        case visaPrice = "Visa Price"
    }
    
    init(visaPrice: [VisaPrice]) {
        self.visaPrice = visaPrice
    }
}

// MARK: - VisaPrice
class VisaPrice: Codable {
    let price, status, success, adultPrice: String
    let childPrice, passPrice, promoCodePrice: String
    let promoCodePriceStatus: Int
    let promoCodePriceType: String
    
    enum CodingKeys: String, CodingKey {
        case price, status, success
        case adultPrice = "adult_price"
        case childPrice = "child_price"
        case passPrice = "pass_price"
        case promoCodePrice = "promo_code_price"
        case promoCodePriceStatus = "promo_code_price_status "
        case promoCodePriceType = "promo_code_price_type"
    }
    
    init(price: String, status: String, success: String, adultPrice: String, childPrice: String, passPrice: String, promoCodePrice: String, promoCodePriceStatus: Int, promoCodePriceType: String) {
        self.price = price
        self.status = status
        self.success = success
        self.adultPrice = adultPrice
        self.childPrice = childPrice
        self.passPrice = passPrice
        self.promoCodePrice = promoCodePrice
        self.promoCodePriceStatus = promoCodePriceStatus
        self.promoCodePriceType = promoCodePriceType
    }
}
