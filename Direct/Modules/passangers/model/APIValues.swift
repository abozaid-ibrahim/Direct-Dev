//
//  APIValues.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

enum MartialState: String {
    case single, married
    var apiValue: Int {
        switch self {
        case .single:
            return 0
        case .married:
            return 1
        }
    }

    var string: String {
        return rawValue.localized
    }
}

enum AgreementValues: String {
    case yes, no
    var apiValue: Int {
        switch self {
        case .no:
            return 0
        case .yes:
            return 1
        }
    }

    var string: String {
        return rawValue.localized
    }
}
