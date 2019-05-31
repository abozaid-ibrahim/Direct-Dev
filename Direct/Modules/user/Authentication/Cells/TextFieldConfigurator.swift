//
//  TextFieldConfigurator.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit

struct TextFieldConfigurator {
    var placeHolder: String?
    var isSecured = false
    var keyboardType: UIKeyboardType {
        switch type {
        case .email:
            return .emailAddress
        case .phonenumber, .phoneConfirmNumber:
            return .phonePad
        default:
            return .default
        }
    }

    var type: AuthCellType
    var inputType: UITextContentType? {
        switch type {
        case .password, .confirmPass:
            return .password
        case .address:
            return .addressCity
        case .email:
            return .username
        case .fullname:
            return .name
        case .phoneConfirmNumber:
            if #available(iOS 12.0, *) {
                return .oneTimeCode
            } else {
                fallthrough
            }
        case .phonenumber:
            return .telephoneNumber
        case .countryKey:
            return .postalCode
        default:
            return nil
        }
    }
}
