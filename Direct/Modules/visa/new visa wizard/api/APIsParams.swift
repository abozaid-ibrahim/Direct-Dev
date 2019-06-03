//
//  APIsParams.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
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
        return "ar"
    }
}
