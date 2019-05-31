//
//  SignupUserData.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/8/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation

struct UserSignupInfo {
    var email, phone, fullname, password, confirmPassword: String

    init (fullname: String, email: String, countryCode: String, phone: String, password: String, confirmPassword: String) {
        self.email = email
        self.phone = "\(countryCode)\(phone)"
        self.password = password
        self.confirmPassword = confirmPassword
        self.fullname = fullname
    }
}

enum DaleelError: Error {
    case serverError(String?)
}

extension DaleelError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError(let str):
            return str ?? "general_error_title".localized
        }
    }
}
