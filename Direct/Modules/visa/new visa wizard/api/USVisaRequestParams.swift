//
//  USVisaRequestParams.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - USRequestParams


struct CountriesParamsKeysBuilder {
    enum CodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqID = "visa_req_id"
        case visaReqApplicantID = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case universityAcceptanceImage = "I_20_copy"
        case mothersFirstName = "mothers_first_name"
        case mothersFamilyName = "mothers_family_name"
        case nationality
        case passportCopy = "passport_copy"
        case personalPhotoCopy = "personal_photo_copy"
        case visaLetterCopy = "visa_letter_copy"
        case everIssuedVisaBefore = "ever_issued_visa"
        case previousVisaCopy = "previous_visa_copy"
        case typeOfPreviousVisa = "type_of_previous_visa"
        case travelledBeforeHere = "travelled_before_here"
        case dateOfArrival = "date_of_arrival"
        case periodOfPreviousStay = "period_of_previous_stay"
        case martialStatus = "martial_status"
        case familyIDCopy = "family_id_copy"
        case husbandOrWifeTravelWithYou = "husband_or_wife_travel_with_you"
        case visits
        case have_driver_license
        case visa_cancelled_before
        case before_visa_cancelled_reason
        case any_relatives_here
        case relative_type
    }
}

class USRequestParams: Codable {
    var key, lang, userid, visaReqID: String?
    var visaReqApplicantID, firstName, familyName, mothersFirstName: String?
    var mothersFamilyName, nationality, passportCopy, personalPhotoCopy: String?
    var visaLetterCopy, everIssuedVisaBefore, previousVisaCopy, typeOfPreviousVisa: String?
    var travelledBeforeHere, dateOfArrival, periodOfPreviousStay, martialStatus: String?
    var familyIDCopy, husbandOrWifeTravelWithYou: String?
    var have_driver_license: Int?
    var visa_cancelled_before: Int?
    var before_visa_cancelled_reason: String?
    var universityAcceptanceImage: String?

    var any_relatives_here: Int?
    var relative_type: Int?

    var visits: [Visit]?

    enum CodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqID = "visa_req_id"
        case visaReqApplicantID = "visa_req_applicant_id"
        case firstName = "first_name"
        case familyName = "family_name"
        case universityAcceptanceImage = "l_20"
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
        case familyIDCopy = "family_id_copy"
        case husbandOrWifeTravelWithYou = "husband_or_wife_travel_with_you"
        case visits
        case have_driver_license
        case visa_cancelled_before
        case before_visa_cancelled_reason
        case any_relatives_here
        case relative_type
    }

    init() {
        key = nil
        lang = nil
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
         universityAcceptanceImage:String?) {
        self.key = key
        self.lang = lang
        self.userid = userid
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
}
// MARK: - Visit

class Visit: Codable {
    let cname, year: String?

    init(cname: String?, year: String?) {
        self.cname = cname
        self.year = year
    }
}
