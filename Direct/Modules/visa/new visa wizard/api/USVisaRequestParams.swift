//
//  USVisaRequestParams.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - USRequestParams

class VisaRequirementsParams: Encodable {
    var visaReqID: String?
    var visaReqApplicantID, firstName, familyName, mothersFirstName: String?
    var mothersFamilyName, nationality, passportCopy, personalPhotoCopy: String?
    var visaLetterCopy, everIssuedVisaBefore, previousVisaCopy, typeOfPreviousVisa: String?
    
    var travelledBeforeHere, dateOfArrival, periodOfPreviousStay, martialStatus: String?
    var familyIDCopy, husbandOrWifeTravelWithYou: String?
    
    var have_driver_license: Int?
    var visa_cancelled_before: Int?
    var before_visa_cancelled_reason: String?
    var universityAcceptanceImage: String?
    
    var dateOfIssuingPreviousVisa: String?
    var placeOfIssuingPreviousVisa: String?
    
    var any_relatives_here: Int?
    var relative_type: Int?
    
    var visits: [Visit]?
    var userid: String?
    var country: CountriesIDs?
    
    // unimplemented before
    var nationalIdCopy: String?
    var mothersPlaceOfBirth: String?
    
    func encode(to encoder: Encoder) throws {
        switch country! {
        case .US:
            try encodeUs(encoder)
        case .GB:
            try encodeGB(encoder)
        case .SGN:
            try encodeSGN(encoder)
        case .CN:
            try encodeCN(encoder)
        case .JP, .IE:
            try encodeJapan_Ireland(encoder)
        case .IN:
            try encodeIndia(encoder)
        case .TR:
            try encodeTR(encoder)
        }
    }
    
    init() {
        userid = nil
        visaReqID = nil
        visaReqApplicantID = nil
        firstName = nil
        familyName = nil
        mothersFirstName = nil
        mothersFamilyName = nil
        nationality = nil
        passportCopy = nil
        personalPhotoCopy = nil
        visaLetterCopy = nil
        everIssuedVisaBefore = nil
        previousVisaCopy = nil
        typeOfPreviousVisa = nil
        travelledBeforeHere = nil
        dateOfArrival = nil
        periodOfPreviousStay = nil
        martialStatus = nil
        familyIDCopy = nil
        husbandOrWifeTravelWithYou = nil
        visits = nil
        have_driver_license = nil
        visa_cancelled_before = nil
        before_visa_cancelled_reason = nil
        any_relatives_here = nil
        relative_type = nil
        universityAcceptanceImage = nil
    }
    
    init(key: String?, lang: String?, userid: String?, visaReqID: String?, visaReqApplicantID: String?, firstName: String?, familyName: String?, mothersFirstName: String?, mothersFamilyName: String?, nationality: String?, passportCopy: String?, personalPhotoCopy: String?, visaLetterCopy: String?, everIssuedVisaBefore: String?, previousVisaCopy: String?, typeOfPreviousVisa: String?, travelledBeforeHere: String?, dateOfArrival: String?, periodOfPreviousStay: String?, martialStatus: String?, familyIDCopy: String?, husbandOrWifeTravelWithYou: String?, visits: [Visit]?, have_driver_license: Int?,
         visa_cancelled_before: Int?,
         before_visa_cancelled_reason: String?,
         any_relatives_here: Int?,
         relative_type: Int?,
         universityAcceptanceImage: String?) {
        
        self.visaReqID = visaReqID
        self.visaReqApplicantID = visaReqApplicantID
        self.firstName = firstName
        self.familyName = familyName
        self.mothersFirstName = mothersFirstName
        self.mothersFamilyName = mothersFamilyName
        self.nationality = nationality
        self.passportCopy = passportCopy
        self.personalPhotoCopy = personalPhotoCopy
        self.visaLetterCopy = visaLetterCopy
        self.everIssuedVisaBefore = everIssuedVisaBefore
        self.previousVisaCopy = previousVisaCopy
        self.typeOfPreviousVisa = typeOfPreviousVisa
        self.travelledBeforeHere = travelledBeforeHere
        self.dateOfArrival = dateOfArrival
        self.periodOfPreviousStay = periodOfPreviousStay
        self.martialStatus = martialStatus
        self.familyIDCopy = familyIDCopy
        self.husbandOrWifeTravelWithYou = husbandOrWifeTravelWithYou
        self.visits = visits
        self.have_driver_license = have_driver_license
        self.visa_cancelled_before = visa_cancelled_before
        self.before_visa_cancelled_reason = before_visa_cancelled_reason
        self.any_relatives_here = any_relatives_here
        self.relative_type = relative_type
        self.universityAcceptanceImage = universityAcceptanceImage
    }
    
    // encoding helpers
    func encodeUs(_ encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CountriesParamsFactory.USCodingKeys.self)
        
        try container.encode(visaReqID, forKey: .visaReqId)
        try container.encode(visaReqApplicantID, forKey: .visaReqApplicantId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(mothersFirstName, forKey: .mothersFirstName)
        try container.encode(nationality, forKey: .nationality)
        try container.encode(personalPhotoCopy, forKey: .personalPhotoCopy)
        try container.encode(passportCopy, forKey: .passportCopy)
        try container.encode(previousVisaCopy, forKey: .previousVisaCopy)
        try container.encode(typeOfPreviousVisa, forKey: .typeOfPreviousVisa)
        try container.encode(travelledBeforeHere, forKey: .travelledBefore)
        try container.encode(dateOfArrival, forKey: .dateOfArrival)
        try container.encode(periodOfPreviousStay, forKey: .periodOfPreviousStay)
        try container.encode(martialStatus, forKey: .martialStatus)
        try container.encode(familyIDCopy, forKey: .familyIdCopy)
        try container.encode(have_driver_license, forKey: .haveDriverLicense)
        try container.encode(visa_cancelled_before, forKey: .visaCancelledBefore)
        try container.encode(before_visa_cancelled_reason, forKey: .beforeVisaCancelledReason)
        try container.encode(universityAcceptanceImage, forKey: .i20_Copy)
        try container.encode(dateOfIssuingPreviousVisa, forKey: .dateOfIssuingPreviousVisa)
        try container.encode(placeOfIssuingPreviousVisa, forKey: .placeOfIssuePreviousVisa)
        try container.encode(any_relatives_here, forKey: .anyRelativesHere)
        try container.encode(relative_type, forKey: .relativeType)
        try container.encode(visits, forKey: .visits)
    }
    
    func encodeGB(_ encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CountriesParamsFactory.GBCodingKeys.self)
        
        try container.encode(visaReqID, forKey: .visaReqId)
        try container.encode(visaReqApplicantID, forKey: .visaReqApplicantId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(mothersFirstName, forKey: .mothersFirstName)
        try container.encode(mothersFamilyName, forKey: .mothersFamilyName)
        try container.encode(nationality, forKey: .nationality)
        try container.encode(passportCopy, forKey: .passportCopy)
        try container.encode(personalPhotoCopy, forKey: .personalPhotoCopy)
        try container.encode(visaLetterCopy, forKey: .visaLetterCopy)
        try container.encode(everIssuedVisaBefore, forKey: .everIssuedVisaBefore)
        try container.encode(previousVisaCopy, forKey: .previousVisaCopy)
        try container.encode(typeOfPreviousVisa, forKey: .typeOfPreviousVisa)
        try container.encode(travelledBeforeHere, forKey: .travelledBeforeHere)
        try container.encode(dateOfArrival, forKey: .dateOfArrival)
        try container.encode(periodOfPreviousStay, forKey: .periodOfPreviousStay)
        try container.encode(martialStatus, forKey: .martialStatus)
        try container.encode(familyIDCopy, forKey: .familyIdCopy)
        try container.encode(husbandOrWifeTravelWithYou, forKey: .husbandOrWifeTravelWithYou)
        try container.encode(visits, forKey: .visits)
    }
    
    func encodeSGN(_ encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CountriesParamsFactory.SGNCodingKeys.self)
        
        try container.encode(visaReqID, forKey: .visaReqId)
        try container.encode(visaReqApplicantID, forKey: .visaReqApplicantId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(passportCopy, forKey: .travelersPassportCopy)
        try container.encode(nationalIdCopy, forKey: .nationalIdCopy)
        try container.encode(visaLetterCopy, forKey: .visaLetterCopy)
        try container.encode(everIssuedVisaBefore, forKey: .everIssuedVisa)
        try container.encode(previousVisaCopy, forKey: .previousVisaCopy)
        try container.encode(martialStatus, forKey: .socialStatus)
        try container.encode(familyIDCopy, forKey: .familyCardCopy)
    }
    
    func encodeCN(_ encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CountriesParamsFactory.ChainaCodingKeys.self)
        
        try container.encode(visaReqID, forKey: .visaReqId)
        try container.encode(visaReqApplicantID, forKey: .visaReqApplicantId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(passportCopy, forKey: .passportCopy)
        try container.encode(nationalIdCopy, forKey: .nationalIdCopy)
        try container.encode(visaLetterCopy, forKey: .visaLetterCopy)
        try container.encode(everIssuedVisaBefore, forKey: .everIssuedVisaBefore)
        try container.encode(previousVisaCopy, forKey: .previousVisaCopy)
        try container.encode(martialStatus, forKey: .martialStatus)
        try container.encode(familyIDCopy, forKey: .familyIdCopy)
        try container.encode(visits, forKey: .visits)
    }
    
    func encodeJapan_Ireland(_ encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CountriesParamsFactory.Japan_IrelandCodingKeys.self)
        
        try container.encode(visaReqID, forKey: .visaReqId)
        try container.encode(visaReqApplicantID, forKey: .visaReqApplicantId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(passportCopy, forKey: .passportCopy)
        try container.encode(nationalIdCopy, forKey: .nationalIdCopy)
        try container.encode(visaLetterCopy, forKey: .visaLetterCopy)
        try container.encode(everIssuedVisaBefore, forKey: .everIssuedVisaBefore)
        try container.encode(previousVisaCopy, forKey: .previousVisaCopy)
        try container.encode(martialStatus, forKey: .martialStatus)
        try container.encode(familyIDCopy, forKey: .familyIdCopy)
    }
    
    func encodeIndia(_ encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CountriesParamsFactory.IndiaCodingKeys.self)
        
        try container.encode(visaReqID, forKey: .visaReqId)
        try container.encode(visaReqApplicantID, forKey: .visaReqApplicantId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(mothersFirstName, forKey: .mothersFirstName)
        try container.encode(mothersFamilyName, forKey: .mothersFamilyName)
        try container.encode(mothersPlaceOfBirth, forKey: .mothersPlaceOfBirth)
        try container.encode(passportCopy, forKey: .passportCopy)
        try container.encode(nationalIdCopy, forKey: .nationalIdCopy)
        try container.encode(martialStatus, forKey: .socialStatus)
        try container.encode(familyIDCopy, forKey: .familyIdCopy)
        try container.encode(visits, forKey: .visits)
    }
    
    func encodeTR(_ encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CountriesParamsFactory.TRCodingKeys.self)
        
        try container.encode(visaReqID, forKey: .visaReqId)
        try container.encode(visaReqApplicantID, forKey: .visaReqApplicantId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(mothersFirstName, forKey: .mothersFirstName)
        try container.encode(mothersFamilyName, forKey: .mothersFamilyName)
        try container.encode(passportCopy, forKey: .passportCopy)
    }
}

// MARK: - Visit

class Visit: Codable {
    let cname, year: String?
    
    init(cname: String?, year: String?) {
        self.cname = cname
        self.year = year
    }
}
