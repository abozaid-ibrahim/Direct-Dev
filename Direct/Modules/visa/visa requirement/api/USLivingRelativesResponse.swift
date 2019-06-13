//
//  USLivingRelativesResponse.swift
//  Direct
//
//  Created by abuzeid on 6/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class VisaUSLivingRelativesJSONResponse: Codable {
    let usRelatives: [USRelative]?
    
    enum CodingKeys: String, CodingKey {
        case usRelatives = "US Relatives"
    }
    
    init(usRelatives: [USRelative]?) {
        self.usRelatives = usRelatives
    }
}

