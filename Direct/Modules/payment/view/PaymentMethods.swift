//
//  PaymentMethods.swift
//  Direct
//
//  Created by abuzeid on 6/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation


struct CurrentOrder {
    
    var orderTotalSar: Double
    var id: Int
    
}
enum PaymentMethodsIDs: Int {
    case bankTransfer = 8, cach = 3, creditCard = 2
    var icons: String {
        switch self {
        case .bankTransfer:
            return "bankTransfer"
        case .cach:
            return "cashInHand"
        case .creditCard:
            return "icons8StackOfMoney"
        }
    }
}
