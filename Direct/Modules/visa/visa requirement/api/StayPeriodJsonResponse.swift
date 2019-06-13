//
//  StayPeriodJsonResponse.swift
//  Direct
//
//  Created by abuzeid on 6/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class VisaStayPeriodJSONResponse: Codable {
    let periods: [Period]?
    
    enum CodingKeys: String, CodingKey {
        case periods = "Periods"
    }
    
    init(periods: [Period]?) {
        self.periods = periods
    }
}

// MARK: - Period
class Period: Codable {
    let name, id: String?
//    let status: Status?
    let success: String?
    
    init(name: String?, id: String?, success: String?) {
        self.name = name
        self.id = id
//        self.status = status
        self.success = success
    }
}

enum Status: String, Codable {
    case success = "Success."
}
