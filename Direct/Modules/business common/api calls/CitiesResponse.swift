//
//  CitiesResponse.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class CountryCitiesResponse: Codable {
    let dtEmbassyLocations: [DTEmbassyLocation]
    
    enum CodingKeys: String, CodingKey {
        case dtEmbassyLocations = "DT Embassy Locations"
    }
    
    init(dtEmbassyLocations: [DTEmbassyLocation]) {
        self.dtEmbassyLocations = dtEmbassyLocations
    }
}

// MARK: - DTEmbassyLocation
class DTEmbassyLocation: Codable {
    let cityID, cityName, status, success: String
 let price_notes : [Price_notes]?
    enum CodingKeys: String, CodingKey {
        case cityID = "city_id"
        case cityName = "city_name"
        case price_notes = "price_notes"
        case status, success
    }
    
    init(cityID: String, cityName: String, status: String, success: String,notes:[Price_notes]?) {
        self.cityID = cityID
        self.cityName = cityName
        self.status = status
        self.success = success
        self.price_notes = notes
    }
}
