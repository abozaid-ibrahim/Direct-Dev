//
//  CountriesParamsGenerator.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

struct CountriesParamsFactory{
    enum USCodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqId = "visa_req_id"
        case visaReqApplicantId = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case mothersFirstName = "mothers_first_name"
        case mothersFamilyName = "mothers_family_name"
        case nationality
        case passportCopy = "passport_copy"
        case personalPhotoCopy = "personal_photo_copy"
        case i20_Copy = "I_20_copy"
        case everIssuedVisa = "ever_issued_visa"
        case previousVisaCopy = "previous_visa_copy"
        case typeOfPreviousVisa = "type_of_previous_visa"
        case dateOfIssuingPreviousVisa = "date_of_issuing_previous_visa"
        case placeOfIssuePreviousVisa = "Place_of_issue_previous_visa"
        case travelledBefore = "travelled_before"
        case dateOfArrival = "date_of_arrival"
        case periodOfPreviousStay = "period_of_previous_stay"
        case haveDriverLicense = "have_driver_license"
        case visaCancelledBefore = "visa_cancelled_before"
        case beforeVisaCancelledReason = "before_visa_cancelled_reason"
        case martialStatus = "martial_status"
        case familyIdCopy = "family_id_copy"
        case anyRelativesHere = "any_relatives_here"
        case relativeType = "relative_type"
        case visits
    }
    
    
    
    enum GBCodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqId = "visa_req_id"
        case visaReqApplicantId = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case mothersFirstName = "mothers_first_name"
        case mothersFamilyName = "mothers_family_name"
        case nationality
        case passportCopy = "passport_copy"
        case personalPhotoCopy = "personal_photo_copy"
        case visaLetterCopy = "visa_letter_copy"
        case everIssuedVisaBefore = "ever_issued_visa_before"
        case previousVisaCopy = "previous_visa_copy"
        case typeOfPreviousVisa = "type_of_previous_visa"
        case travelledBeforeHere = "travelled_before_here"
        case dateOfArrival = "date_of_arrival"
        case periodOfPreviousStay = "period_of_previous_stay"
        case martialStatus = "martial_status"
        case familyIdCopy = "family_id_copy"
        case husbandOrWifeTravelWithYou = "husband_or_wife_travel_with_you"
        case visits
    }
    
    
    enum SGNCodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqId = "visa_req_id"
        case visaReqApplicantId = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case travelersPassportCopy = "travelers_passport_copy"
        case nationalIdCopy = "national_id_copy"
        case visaLetterCopy = "visa_letter_copy"
        case everIssuedVisa = "ever_issued_visa"
        case previousVisaCopy = "previous_visa_copy"
        case socialStatus = "social_status"
        case familyCardCopy = "family_card_copy"
    }
    
    enum ChainaCodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqId = "visa_req_id"
        case visaReqApplicantId = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case passportCopy = "passport_copy"
        case nationalIdCopy = "national_id_copy"
        case visaLetterCopy = "visa_letter_copy"
        case everIssuedVisaBefore = "ever_issued_visa_before"
        case previousVisaCopy = "previous_visa_copy"
        case martialStatus = "martial_status"
        case familyIdCopy = "family_id_copy"
        case visits
    }
    
    
    enum Japan_IrelandCodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqId = "visa_req_id"
        case visaReqApplicantId = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case passportCopy = "passport_copy"
        case nationalIdCopy = "national_id_copy"
        case visaLetterCopy = "visa_letter_copy"
        case everIssuedVisaBefore = "ever_issued_visa_before"
        case previousVisaCopy = "previous_visa_copy"
        case martialStatus = "martial_status"
        case familyIdCopy = "family_id_copy"
    }
    
    
    enum IndiaCodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqId = "visa_req_id"
        case visaReqApplicantId = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case mothersFirstName = "mothers_first_name"
        case mothersFamilyName = "mothers_family_name"
        case mothersPlaceOfBirth = "mothers_place_of_birth"
        case passportCopy = "passport_copy"
        case nationalIdCopy = "national_id_copy"
        case socialStatus = "social_status"
        case familyIdCopy = "family_id_copy"
        case visits
    }
    
    enum TRCodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqId = "visa_req_id"
        case visaReqApplicantId = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case mothersFirstName = "mothers_first_name"
        case mothersFamilyName = "mothers_family_name"
        case passportCopy = "passport_copy"
    }
}
