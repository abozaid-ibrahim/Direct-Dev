//
//  AuthenticateError.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation

enum AuthenticationError: Error {
    case emailOrPhone, password
    case email, confirmPass, fullname, phonenumber, activateCode
    case blockedAccount, codeSentManyTimesBlock, useYourCode(message: String?)
}

extension AuthenticationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .fullname:
            return "fullname_error".localized
        case .email:
            return "email_error".localized
        case .phonenumber:
            return "phonenumber_error".localized
        case .password:
            return "password_error".localized
        case .activateCode:
            return "activate_code_missing".localized
        case .emailOrPhone:
            return "activate_email_Phone".localized
        case .confirmPass:
            return "confirm_password_error".localized
        case .blockedAccount:
            return "blocked_account_message".localized
        case .codeSentManyTimesBlock:
            return "auth_user_blocked".localized
        case let .useYourCode(message):
            return message ?? "login_activation_message".localized
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
