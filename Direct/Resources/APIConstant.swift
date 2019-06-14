//
//  APIConstant.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 6/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

enum APIConstant: String {
    case Key = "bf930e30-8c28-42d6-bf8e-f4cbd0b83774"
}

enum CountriesIDs: Int {
    case US = 1,
        GB = 2,
        SGN = 3,
        IN = 4,
        CN = 5,
        JP = 6,
        IE = 7,
        TR = 8

    var endPointPath: String {
        switch self {
        case .US:
            return "to-apply-us"
        case .GB:
            return "to-apply-gb"
        case .SGN:
            return "to-apply-sgn"
        case .IN:
            return "to-apply-in"
        case .CN:
            return "to-apply-cn"
        case .JP:
            return "to-apply-jp"
        case .IE:
            return "to-apply-ie"
        case .TR:
            return "to-apply-tr"
        }
    }
}
