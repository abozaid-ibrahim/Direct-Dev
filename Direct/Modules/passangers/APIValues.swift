//
//  APIValues.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
enum MartialState:String{
    case single = "اعزب",married = "متزوج"
    var apiValue:Int{
        switch self {
        case .single:
            return 0
        case .married:
            return 1
        }
    }
}


enum AgreementValues:String{
    case yes = "نعم" ,no = "لا"
    var apiValue:Int{
        switch self {
        case .no:
            return 0
        case .yes:
            return 1
        }
    }
}
