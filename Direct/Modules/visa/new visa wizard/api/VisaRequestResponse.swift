//
//  VisaRequestResponse.swift
//  Direct
//
//  Created by abuzeid on 5/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation


// MARK: - Welcome
class VisaRequestResponse: Codable {
    let visaServices: [VisaService]
    
    enum CodingKeys: String, CodingKey {
        case visaServices = "Visa Services"
    }
    
    init(visaServices: [VisaService]) {
        self.visaServices = visaServices
    }
}

// MARK: - VisaService
class VisaService: Codable {
    let status, success: String
    let requestID: Int
    let query: String
    let visaServiceIn: In
    
    enum CodingKeys: String, CodingKey {
        case status, success
        case requestID = "request_id"
        case query
        case visaServiceIn = "in"
    }
    
    init(status: String, success: String, requestID: Int, query: String, visaServiceIn: In) {
        self.status = status
        self.success = success
        self.requestID = requestID
        self.query = query
        self.visaServiceIn = visaServiceIn
    }
}

// MARK: - In
class In: Codable {
    let updateOn, updateBy, visaCountryID, requestSource: String
    let requestSourceComments, travelDate, biometryLOCID, noOfAdult: String
    let noOfChild, noOfPassport, relationWithTravelers, lang: String
    let promoPrice, promoCode: String
    
    enum CodingKeys: String, CodingKey {
        case updateOn = "update_on"
        case updateBy = "update_by"
        case visaCountryID = "visa_country_id"
        case requestSource = "request_source"
        case requestSourceComments = "request_source_comments"
        case travelDate = "travel_date"
        case biometryLOCID = "biometry_loc_id"
        case noOfAdult = "no_of_adult"
        case noOfChild = "no_of_child"
        case noOfPassport = "no_of_passport"
        case relationWithTravelers = "relation_with_travelers"
        case lang
        case promoPrice = "promo_price"
        case promoCode = "promo_code"
    }
    
    init(updateOn: String, updateBy: String, visaCountryID: String, requestSource: String, requestSourceComments: String, travelDate: String, biometryLOCID: String, noOfAdult: String, noOfChild: String, noOfPassport: String, relationWithTravelers: String, lang: String, promoPrice: String, promoCode: String) {
        self.updateOn = updateOn
        self.updateBy = updateBy
        self.visaCountryID = visaCountryID
        self.requestSource = requestSource
        self.requestSourceComments = requestSourceComments
        self.travelDate = travelDate
        self.biometryLOCID = biometryLOCID
        self.noOfAdult = noOfAdult
        self.noOfChild = noOfChild
        self.noOfPassport = noOfPassport
        self.relationWithTravelers = relationWithTravelers
        self.lang = lang
        self.promoPrice = promoPrice
        self.promoCode = promoCode
    }
}
