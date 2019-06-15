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

enum CountriesIDs: Int,Equatable {
    init(formType:String){
        switch formType {
        case CountriesIDs.US.formType:
            self = CountriesIDs.US
        case CountriesIDs.GB.formType:
           self = CountriesIDs.GB
        case CountriesIDs.SGN.formType:
            self = CountriesIDs.SGN
        case CountriesIDs.IN.formType:
             self = CountriesIDs.IN
        case CountriesIDs.CN.formType:
            self = CountriesIDs.CN
        case CountriesIDs.JP.formType:
           self = CountriesIDs.JP
        case CountriesIDs.IE.formType:
            self = CountriesIDs.IE
        case CountriesIDs.TR.formType:
             self = CountriesIDs.TR
        default:
            
              self = CountriesIDs.US
        }
    }
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
    var formType: String {
        switch self {
        case .US:
            return "us"
        case .GB:
            return "gb"
        case .SGN:
            return "sgn"
        case .IN:
            return "in"
        case .CN:
            return "cn"
        case .JP:
            return "jp"
        case .IE:
            return "ie"
        case .TR:
            return "tr"
        }
    }
    
    
   

   
}


//enum FormType{
//    var formType: String {
//        switch self {
//        case .US:
//            return "us"
//        case .GB:
//            return "gb"
//        case .SGN:
//            return "sgn"
//        case .IN:
//            return "in"
//        case .CN:
//            return "cn"
//        case .JP:
//            return "jp"
//        case .IE:
//            return "ie"
//        case .TR:
//            return "tr"
//        }
//    }
//}
