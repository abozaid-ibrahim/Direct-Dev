//
//  NewVisaCountriesResponse.swift
//  Direct
//
//  Created by abuzeid on 5/26/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - NewVisaCountriesResponse
class NewVisaCountriesResponse: Codable {
    let newVisaServices: [NewVisaService]
    
    enum CodingKeys: String, CodingKey {
        case newVisaServices = "New Visa Services"
    }
    
    init(newVisaServices: [NewVisaService]) {
        self.newVisaServices = newVisaServices
    }
}

// MARK: - NewVisaService
class NewVisaService: Codable {
    let countryID,  countryName: String
    let priceIncludesTextEn, priceIncludesTextAr:String?
    let bioNotes: String
    let visatypes: [Visatype]
    let isBiometryReq: IsBiometryReq
    let thankYouVideoURL: String
    let formType, phoneCode: String?
    let priceBasedOn: PriceBasedOn
    let flagBg: String
    let flag: String
    let status: Status
    let success, success111: String?
    
    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case priceIncludesTextEn = "price_includes_text_en"
        case priceIncludesTextAr = "price_includes_text_ar"
        case countryName = "CountryName"
        case bioNotes = "bio_notes"
        case visatypes
        case isBiometryReq = "is_biometry_req"
        case thankYouVideoURL = "thank_you_video_url"
        case formType = "form_type"
        case phoneCode = "phone_code"
        case priceBasedOn = "price_based_on"
        case flagBg = "flag_bg"
        case flag, status, success, success111
    }
    
    init(countryID: String, priceIncludesTextEn: String?, priceIncludesTextAr: String?, countryName: String, bioNotes: String, visatypes: [Visatype], isBiometryReq: IsBiometryReq, thankYouVideoURL: String, formType: String, phoneCode: String?, priceBasedOn: PriceBasedOn, flagBg: String, flag: String, status: Status, success: String?, success111: String?) {
        self.countryID = countryID
        self.priceIncludesTextEn = priceIncludesTextEn
        self.priceIncludesTextAr = priceIncludesTextAr
        self.countryName = countryName
        self.bioNotes = bioNotes
        self.visatypes = visatypes
        self.isBiometryReq = isBiometryReq
        self.thankYouVideoURL = thankYouVideoURL
        self.formType = formType
        self.phoneCode = phoneCode
        self.priceBasedOn = priceBasedOn
        self.flagBg = flagBg
        self.flag = flag
        self.status = status
        self.success = success
        self.success111 = success111
    }
}

enum IsBiometryReq: String, Codable {
    case no = "no"
    case yes = "yes"
}

enum PriceBasedOn: String, Codable {
    case passport = "passport"
    case traveler = "traveler"
}

enum Status: String, Codable {
    case success = "Success"
}

// MARK: - Visatype
class Visatype: Codable {
    let visaTypeName: VisaTypeName
    let visaTypeID: String
    let status: Status
    let success: String
    
    enum CodingKeys: String, CodingKey {
        case visaTypeName = "VisaTypeName"
        case visaTypeID = "VisaTypeId"
        case status, success
    }
    
    init(visaTypeName: VisaTypeName, visaTypeID: String, status: Status, success: String) {
        self.visaTypeName = visaTypeName
        self.visaTypeID = visaTypeID
        self.status = status
        self.success = success
    }
}

enum VisaTypeName: String, Codable {
    case study = "Study"
    case visit = "Visit"
}
