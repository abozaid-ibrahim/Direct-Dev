//
//  ConfirmationModel.swift
//  Direct
//
//  Created by abuzeid on 7/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

struct ConfirmPassangerItem {
    let text: String
    var isFormFilled: Bool
    var index: Int
    var userType: UserAge // child or adult
}

enum UserAge: Int {
    case adult = 1
    case child = 2
}
