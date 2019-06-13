//
//  AuthCoordinator.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import SwifterSwift
import UIKit

class AuthCoordinator {
    private weak var viewController: AuthTableViewController?

    var collectedData = [String: String]()
    private var signupUser: UserSignupInfo?

    init(viewController: AuthTableViewController?) {
        self.viewController = viewController
    }

    func labelClicked(type: AuthCellType) {
        collectedData.removeAll(keepingCapacity: false)
        switch type {
        case .registerSegue:
            // change vc type to register
            viewController?.type = .register
        case .loginSegue:
            // change vc type to login
            viewController?.type = .login
        case .forgetPassSegue:
            // change vc type to forget
            viewController?.type = .recoverPassword
        default:
            break
        }
    }

    func didTap(button sender: LoadingButton, data: ButtonCellConfigurator) {
        viewController?.view.endEditing(true)
        guard let type = viewController?.type else {
            return
        }
        switch type {
        case .login:
            login(sender)
        case .register:
            // verify signup info
            do {
                let data = try getSignupData()
                sender.startAnimating()
//                register(user: data) {
//                    sender.stopAnimating()
//                }
            } catch {
                showError(error)
            }

        case let .createNewPassword(key):

            guard let email = collectedData[AuthCellType.email.rawValue], email.isEmail else {
                showError(AuthenticationError.email)
                return
            }
            guard let password = collectedData[AuthCellType.password.rawValue], !password.isEmpty else {
                showError(AuthenticationError.password)
                return
            }

            guard let verpassword = collectedData[AuthCellType.confirmPass.rawValue], !verpassword.isEmpty, password == verpassword else {
                showError(AuthenticationError.confirmPass)
                return
            }
            sender.startAnimating()
//            setPassword(new: password, email: email, key: key) {
//                sender.stopAnimating()
//            }

        case .recoverPassword:
            guard let email = collectedData[AuthCellType.email.rawValue], email.isEmail else {
                showError(AuthenticationError.email)
                return
            }
            sender.startAnimating()
//            resetPassword(email: email) {
//                sender.stopAnimating()
//            }

        case .verifyPhoneNumber, .verifyPhoneNumberLogin:
            if data.type == .phoneCodeResend {
                sender.startAnimating()
//                resendPhoneActivation {
//                    sender.stopAnimating()
//                }
            } else {
                // verify
                guard let code = collectedData[AuthCellType.phoneConfirmNumber.rawValue], !code.isEmpty else {
                    showError(AuthenticationError.activateCode)
                    return
                }
                sender.startAnimating()
//                activatephone(code: code) {
//                    sender.stopAnimating()
//                }
            }
        }
    }

    func getSignupData() throws -> UserSignupInfo {
        guard let fullname = collectedData[AuthCellType.fullname.rawValue] else {
            throw AuthenticationError.fullname
        }

        guard let email = collectedData[AuthCellType.email.rawValue], email.isEmail else {
            throw AuthenticationError.email
        }

        guard let phone = collectedData[AuthCellType.phonenumber.rawValue],
            let code = collectedData[AuthCellType.countryKey.rawValue] else {
            throw AuthenticationError.phonenumber
        }

        guard let password = collectedData[AuthCellType.password.rawValue] else {
            throw AuthenticationError.password
        }

        if #available(iOS 12.0, *) {
            collectedData[AuthCellType.confirmPass.rawValue] = password
        }

        guard let confirmPassword = collectedData[AuthCellType.confirmPass.rawValue], confirmPassword == password else {
            throw AuthenticationError.confirmPass
        }

        return UserSignupInfo(fullname: fullname, email: email, countryCode: code, phone: phone, password: password, confirmPassword: confirmPassword)
    }

    func textChanged(values: [String: String]) {
        collectedData = collectedData.merging(values,
                                              uniquingKeysWith: { _, last in last })
    }
}

extension AuthCoordinator {
    // MARK: - Login

    func login(_ sender: LoadingButton) {
        viewController?.view.endEditing(true)
        sender.startAnimating()
        let id = collectedData[AuthCellType.email.rawValue]
        let pass = collectedData[AuthCellType.password.rawValue]
        let command = LoginCommandsFactory.getLoginCommand(id: id ?? "", password: pass ?? "") { [weak self] _ in
//            self?.handleServerLogin(response)
            sender.stopAnimating()
            self?.viewController?.dismiss(animated: true, completion: nil)
        }
        do {
            try command.execute()
        } catch {
            sender.stopAnimating()
            showError(error)
        }
    }

    func showError(_ error: Error) {
        if let error = error as? LocalizedError {
            viewController?.showError(sub: error.errorDescription)
        } else {
            viewController?.showError(sub: error.localizedDescription)
        }
    }
}
