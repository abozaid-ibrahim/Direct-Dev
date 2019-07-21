//
//  APIsParams.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Localize_Swift
protocol NeedAuth: Codable {
    var lang: String { get set }
    var key: String { get set }
}

class VisaRequestParams {
    var userid: String!,
        country_id: String!,
        biometry_loc_id: String?,
        no_of_adult: String!,
        no_of_child: String!,
        no_of_passport: String!,
        visatype: String!,
        travel_date: String!,
        relation_with_travelers: String!,
        request_source: String!,
        request_source_comments: String!,
        promo_code: String!

    var totalCost: String?,
        countryName: String?,
        biometry_loc: String?,
        visatypeText: String?,
        relation_with_travelersText: String?
    var form_type: String?
    var requestID: String?
    var thankYouUrl: String?
}

struct VisaPriceParams {
    var cid: String,
        cityid: String,
        no_of_adult: String,
        no_of_child: String,
        no_of_passport: String,
        promo_code: String,
        visatype: String
}

class AppLanguage {
    static var langCode: String {
        return Localize.currentLanguage()
    }

    static var languages: [LangEntity] {
        return [LangEntity(name: "Arabic".localized(), code: "ar", selected: Localize.currentLanguage() == "ar"),
                LangEntity(name: "English".localized(), code: "en", selected: Localize.currentLanguage() == "en")]
    }

    static var currentLangName: String {
        return languages.filter { $0.selected }.first!
            .name
    }

    static func setCurrent(language: String) {
        Localize.setCurrentLanguage(language)
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

struct LangEntity {
    var name: String
    var code: String
    var selected: Bool
    mutating func did(select: Bool) {
        selected = select
    }
}
