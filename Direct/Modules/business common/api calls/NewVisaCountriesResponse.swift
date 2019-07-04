//
//  NewVisaCountriesResponse.swift
//  Direct
//
//  Created by abuzeid on 5/26/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
struct NewVisaCountriesResponse: Codable {
    let newVisaServices: [NewVisaServices]?

    enum CodingKeys: String, CodingKey {
        case newVisaServices = "New Visa Services"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        newVisaServices = try values.decodeIfPresent([NewVisaServices].self, forKey: .newVisaServices)
    }
}

struct NewVisaServices: Codable {
    let country_id: String?
    let price_notes: [Price_notes]?
    let countryName: String?
    let bio_notes: String?
    let visatypes: [Visatypes]?
    let is_biometry_req: String?
    let thank_you_video_url: String?
    let form_type: String?
    let price_based_on: String?
    let flag_bg: String?
    let flag: String?
    let status: String?
    let success: String?

    enum CodingKeys: String, CodingKey {
        case country_id
        case price_notes
        case countryName = "CountryName"
        case bio_notes
        case visatypes
        case is_biometry_req
        case thank_you_video_url
        case form_type
        case price_based_on
        case flag_bg
        case flag
        case status
        case success
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        price_notes = try values.decodeIfPresent([Price_notes].self, forKey: .price_notes)
        countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
        bio_notes = try values.decodeIfPresent(String.self, forKey: .bio_notes)
        visatypes = try values.decodeIfPresent([Visatypes].self, forKey: .visatypes)
        is_biometry_req = try values.decodeIfPresent(String.self, forKey: .is_biometry_req)
        thank_you_video_url = try values.decodeIfPresent(String.self, forKey: .thank_you_video_url)
        form_type = try values.decodeIfPresent(String.self, forKey: .form_type)
        price_based_on = try values.decodeIfPresent(String.self, forKey: .price_based_on)
        flag_bg = try values.decodeIfPresent(String.self, forKey: .flag_bg)
        flag = try values.decodeIfPresent(String.self, forKey: .flag)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        success = try values.decodeIfPresent(String.self, forKey: .success)
    }
}

struct Visatypes: Codable {
    let visaTypeName: String?
    let visaTypeId: String?
    let status: String?
    let success: String?

    enum CodingKeys: String, CodingKey {
        case visaTypeName = "VisaTypeName"
        case visaTypeId = "VisaTypeId"
        case status
        case success
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        visaTypeName = try values.decodeIfPresent(String.self, forKey: .visaTypeName)
        visaTypeId = try values.decodeIfPresent(String.self, forKey: .visaTypeId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        success = try values.decodeIfPresent(String.self, forKey: .success)
    }
    init(name:String,id:String) {
        self.visaTypeName = name
        self.visaTypeId = id
        self.status = nil
        self.success = nil
    }
}

struct Price_notes: Codable {
    let text: String?
    let note_type: Int?

    enum CodingKeys: String, CodingKey {
        case text
        case note_type
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        note_type = try values.decodeIfPresent(Int.self, forKey: .note_type)
    }
}

/***

 //
 //// MARK: - NewVisaCountriesResponse
 //class NewVisaCountriesResponse: Codable {
 //    let newVisaServices: [NewVisaService]
 //
 //    enum CodingKeys: String, CodingKey {
 //        case newVisaServices = "New Visa Services"
 //    }
 //
 //    init(newVisaServices: [NewVisaService]) {
 //        self.newVisaServices = newVisaServices
 //    }
 //}
 //
 //// MARK: - NewVisaService
 //class NewVisaService: Codable {
 //    let countryID,  countryName: String
 //    let priceIncludesTextEn, priceIncludesTextAr:String?
 //    let bioNotes: String
 //    let visatypes: [Visatype]?
 //    let isBiometryReq: IsBiometryReq
 //    let thankYouVideoURL: String
 //    let formType, phoneCode: String?
 //    let priceBasedOn: PriceBasedOn
 //    let flagBg: String
 //    let flag: String
 //    let status: Status
 //    let success, success111: String?
 //
 //    enum CodingKeys: String, CodingKey {
 //        case countryID = "country_id"
 //        case priceIncludesTextEn = "price_includes_text_en"
 //        case priceIncludesTextAr = "price_includes_text_ar"
 //        case countryName = "CountryName"
 //        case bioNotes = "bio_notes"
 //        case visatypes
 //        case isBiometryReq = "is_biometry_req"
 //        case thankYouVideoURL = "thank_you_video_url"
 //        case formType = "form_type"
 //        case phoneCode = "phone_code"
 //        case priceBasedOn = "price_based_on"
 //        case flagBg = "flag_bg"
 //        case flag, status, success, success111
 //    }
 //
 //    init(countryID: String, priceIncludesTextEn: String?, priceIncludesTextAr: String?, countryName: String, bioNotes: String, visatypes: [Visatype]?, isBiometryReq: IsBiometryReq, thankYouVideoURL: String, formType: String, phoneCode: String?, priceBasedOn: PriceBasedOn, flagBg: String, flag: String, status: Status, success: String?, success111: String?) {
 //        self.countryID = countryID
 //        self.priceIncludesTextEn = priceIncludesTextEn
 //        self.priceIncludesTextAr = priceIncludesTextAr
 //        self.countryName = countryName
 //        self.bioNotes = bioNotes
 //        self.visatypes = visatypes
 //        self.isBiometryReq = isBiometryReq
 //        self.thankYouVideoURL = thankYouVideoURL
 //        self.formType = formType
 //        self.phoneCode = phoneCode
 //        self.priceBasedOn = priceBasedOn
 //        self.flagBg = flagBg
 //        self.flag = flag
 //        self.status = status
 //        self.success = success
 //        self.success111 = success111
 //    }
 //}
 //
 //enum IsBiometryReq: String, Codable {
 //    case no = "no"
 //    case yes = "yes"
 //}
 //
 //enum PriceBasedOn: String, Codable {
 //    case passport = "passport"
 //    case traveler = "traveler"
 //}
 //
 //enum Status: String, Codable {
 //    case success = "Success"
 //}
 //
 //// MARK: - Visatype
 //class Visatype: Codable {
 //    let visaTypeName: VisaTypeName?
 //    let visaTypeID: String
 //    let status: Status
 //    let success: String
 //
 //    enum CodingKeys: String, CodingKey {
 //        case visaTypeName = "VisaTypeName"
 //        case visaTypeID = "VisaTypeId"
 //        case status, success
 //    }
 //
 //    init(visaTypeName: VisaTypeName?, visaTypeID: String, status: Status, success: String) {
 //        self.visaTypeName = visaTypeName
 //        self.visaTypeID = visaTypeID
 //        self.status = status
 //        self.success = success
 //    }
 //}
 //
 //enum VisaTypeName: String, Codable {
 //    case study = "Study"
 //    case visit = "Visit"
 //}
 */
