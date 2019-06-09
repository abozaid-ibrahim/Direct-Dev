//
//  USVisaRequestParams.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - USRequestParams
class USRequestParams: Codable {
    var key, lang, userid, visaReqID: String?
    var visaReqApplicantID, firstName, familyName, mothersFirstName: String?
    var mothersFamilyName, nationality, passportCopy, personalPhotoCopy: String?
    var visaLetterCopy, everIssuedVisaBefore, previousVisaCopy, typeOfPreviousVisa: String?
    var travelledBeforeHere, dateOfArrival, periodOfPreviousStay, martialStatus: String?
    var familyIDCopy, husbandOrWifeTravelWithYou: String?
    var have_driver_license:Int?
    var visa_cancelled_before:Int?
    var before_visa_cancelled_reason:String?
    var any_relatives_here:Int?
    var relative_type:Int?
    

    var visits: [Visit]?
    
    enum CodingKeys: String, CodingKey {
        case key, lang, userid
        case visaReqID = "visa_req_id"
        case visaReqApplicantID = "visa_req_applicant_id"
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
        self.key = nil
        self.lang = nil
        self.userid = nil
        self.visaReqID = nil
        self.visaReqApplicantID = nil
        self.firstName = nil
        self.familyName = nil
        self.mothersFirstName = nil
        self.mothersFamilyName = nil
        self.nationality = nil
        self.passportCopy = nil
        self.personalPhotoCopy = nil
        self.visaLetterCopy = nil
        self.everIssuedVisaBefore = nil
        self.previousVisaCopy = nil
        self.typeOfPreviousVisa = nil
        self.travelledBeforeHere = nil
        self.dateOfArrival = nil
        self.periodOfPreviousStay = nil
        self.martialStatus = nil
        self.familyIDCopy = nil
        self.husbandOrWifeTravelWithYou = nil
        self.visits = nil
        self.have_driver_license = nil
        self.visa_cancelled_before = nil
        self.before_visa_cancelled_reason = nil
        self.any_relatives_here = nil
        self.relative_type = nil
        
    }
    init(key: String?, lang: String?, userid: String?, visaReqID: String?, visaReqApplicantID: String?, firstName: String?, familyName: String?, mothersFirstName: String?, mothersFamilyName: String?, nationality: String?, passportCopy: String?, personalPhotoCopy: String?, visaLetterCopy: String?, everIssuedVisaBefore: String?, previousVisaCopy: String?, typeOfPreviousVisa: String?, travelledBeforeHere: String?, dateOfArrival: String?, periodOfPreviousStay: String?, martialStatus: String?, familyIDCopy: String?, husbandOrWifeTravelWithYou: String?, visits: [Visit]?, have_driver_license:Int?
    , visa_cancelled_before:Int?
    , before_visa_cancelled_reason:String?
    , any_relatives_here:Int?
    , relative_type:Int?
    ) {
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
    }
}
//
//// MARK: USRequestParams convenience initializers and mutators
//
//extension USRequestParams {
//    convenience init(data: Data) throws {
//        let me = try newJSONDecoder().decode(USRequestParams.self, from: data)
//        self.init(key: me.key, lang: me.lang, userid: me.userid, visaReqID: me.visaReqID, visaReqApplicantID: me.visaReqApplicantID, firstName: me.firstName, familyName: me.familyName, mothersFirstName: me.mothersFirstName, mothersFamilyName: me.mothersFamilyName, nationality: me.nationality, passportCopy: me.passportCopy, personalPhotoCopy: me.personalPhotoCopy, visaLetterCopy: me.visaLetterCopy, everIssuedVisaBefore: me.everIssuedVisaBefore, previousVisaCopy: me.previousVisaCopy, typeOfPreviousVisa: me.typeOfPreviousVisa, travelledBeforeHere: me.travelledBeforeHere, dateOfArrival: me.dateOfArrival, periodOfPreviousStay: me.periodOfPreviousStay, martialStatus: me.martialStatus, familyIDCopy: me.familyIDCopy, husbandOrWifeTravelWithYou: me.husbandOrWifeTravelWithYou, visits: me.visits)
//    }
//
//    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//
//    convenience init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//
//    func with(
//        key: String?? = nil,
//        lang: String?? = nil,
//        userid: String?? = nil,
//        visaReqID: String?? = nil,
//        visaReqApplicantID: String?? = nil,
//        firstName: String?? = nil,
//        familyName: String?? = nil,
//        mothersFirstName: String?? = nil,
//        mothersFamilyName: String?? = nil,
//        nationality: String?? = nil,
//        passportCopy: String?? = nil,
//        personalPhotoCopy: String?? = nil,
//        visaLetterCopy: String?? = nil,
//        everIssuedVisaBefore: String?? = nil,
//        previousVisaCopy: String?? = nil,
//        typeOfPreviousVisa: String?? = nil,
//        travelledBeforeHere: String?? = nil,
//        dateOfArrival: String?? = nil,
//        periodOfPreviousStay: String?? = nil,
//        martialStatus: String?? = nil,
//        familyIDCopy: String?? = nil,
//        husbandOrWifeTravelWithYou: String?? = nil,
//        visits: [Visit]?? = nil
//        ) -> USRequestParams {
//        return USRequestParams(
//            key: key ?? self.key,
//            lang: lang ?? self.lang,
//            userid: userid ?? self.userid,
//            visaReqID: visaReqID ?? self.visaReqID,
//            visaReqApplicantID: visaReqApplicantID ?? self.visaReqApplicantID,
//            firstName: firstName ?? self.firstName,
//            familyName: familyName ?? self.familyName,
//            mothersFirstName: mothersFirstName ?? self.mothersFirstName,
//            mothersFamilyName: mothersFamilyName ?? self.mothersFamilyName,
//            nationality: nationality ?? self.nationality,
//            passportCopy: passportCopy ?? self.passportCopy,
//            personalPhotoCopy: personalPhotoCopy ?? self.personalPhotoCopy,
//            visaLetterCopy: visaLetterCopy ?? self.visaLetterCopy,
//            everIssuedVisaBefore: everIssuedVisaBefore ?? self.everIssuedVisaBefore,
//            previousVisaCopy: previousVisaCopy ?? self.previousVisaCopy,
//            typeOfPreviousVisa: typeOfPreviousVisa ?? self.typeOfPreviousVisa,
//            travelledBeforeHere: travelledBeforeHere ?? self.travelledBeforeHere,
//            dateOfArrival: dateOfArrival ?? self.dateOfArrival,
//            periodOfPreviousStay: periodOfPreviousStay ?? self.periodOfPreviousStay,
//            martialStatus: martialStatus ?? self.martialStatus,
//            familyIDCopy: familyIDCopy ?? self.familyIDCopy,
//            husbandOrWifeTravelWithYou: husbandOrWifeTravelWithYou ?? self.husbandOrWifeTravelWithYou,
//            visits: visits ?? self.visits
//        )
//    }
//
//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }
//
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//}

// MARK: - Visit
class Visit: Codable {
    let cname, year: String?

    init(cname: String?, year: String?) {
        self.cname = cname
        self.year = year
    }
}

// MARK: Visit convenience initializers and mutators

//extension Visit {
//    convenience init(data: Data) throws {
//        let me = try newJSONDecoder().decode(Visit.self, from: data)
//        self.init(cname: me.cname, year: me.year)
//    }
//
//    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//
//    convenience init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//
//    func with(
//        cname: String?? = nil,
//        year: String?? = nil
//        ) -> Visit {
//        return Visit(
//            cname: cname ?? self.cname,
//            year: year ?? self.year
//        )
//    }
//
//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }
//
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//}
//
//// MARK: - Helper functions for creating encoders and decoders
//
//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}
