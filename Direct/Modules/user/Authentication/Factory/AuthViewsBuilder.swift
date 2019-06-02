//
//  AuthViewsBuilder.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/3/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import UIKit

enum AuthElement {
    case textField(TextFieldConfigurator)
    case button(ButtonCellConfigurator)
    case textLabel(TextLabelConfigurator)
    case phoneNumber(TextFieldConfigurator)
    case title(String)
}

enum AuthCellType: String {
    case email, password, confirmPass, phonenumber, fullname, address, phoneConfirmNumber, countryKey
    case loginSegue, registerSegue, forgetPassSegue, phoneCodeResend, verifyPhoneCode, phoneCodeResendWait
}

struct AuthViewsBuilder {

    // MARK: - Helpers and static text with style
    fileprivate static func styleText(_ main: String, _ sub: String) -> NSAttributedString {
        let att = NSMutableAttributedString(string: main, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9874494672, green: 0.5041492581, blue: 0.00973271206, alpha: 1), NSAttributedString.Key.font: UIFont.getLocalizedFont(type: .bold(12)), NSAttributedString.Key.writingDirection: [NSWritingDirection.rightToLeft.rawValue]])
        let subAt = NSAttributedString(string: sub, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6871660352, green: 0.4308405519, blue: 0.671536684, alpha: 1), NSAttributedString.Key.font: UIFont.getLocalizedFont(type: .bold(12)), NSAttributedString.Key.writingDirection: [NSWritingDirection.rightToLeft.rawValue]])
        att.append(subAt)
        return NSAttributedString(attributedString: att)
    }

    fileprivate static var forgetPassword: NSAttributedString {
        let main = "forget_password_label".localized
        return styleText(main, "")
    }

    fileprivate static var newAccount: NSAttributedString {
        let main = "create_new_account_label".localized
        let sub = "create_new_clicable".localized
        return styleText(main, sub)
    }

    fileprivate static var login: NSAttributedString {
        let main = "login_btn_segue_label".localized + " "
        let sub = "login_btn_clickable".localized
        return styleText(main, sub)
    }

    // MARK: - Views data
    static var loginViewData: [AuthElement] {
        return [
            .textField(TextFieldConfigurator(placeHolder: "email_phone_tf_placeHolder".localized, isSecured: false, type: .email)),
            .textField(TextFieldConfigurator(placeHolder: "password_tf_placeHolder".localized, isSecured: true, type: .password)),
            .textLabel(TextLabelConfigurator(attributedText: forgetPassword, type: .forgetPassSegue)),
            .button(ButtonCellConfigurator(title: "login_btn_label".localized, color: .white, background: .black, type: .loginSegue))
            ]
    }

    static var signupViewData: [AuthElement] {
        return [
            .textField(TextFieldConfigurator(placeHolder: "fullname_tf_placeholder".localized, isSecured: false, type: .fullname)),
            .textField(TextFieldConfigurator(placeHolder: "email_placeholder".localized, isSecured: false, type: .email)),
            .phoneNumber(TextFieldConfigurator(placeHolder: "phone_number_placeholder".localized, isSecured: false, type: .phonenumber)),
            .textField(TextFieldConfigurator(placeHolder: "password_tf_placeHolder".localized, isSecured: true, type: .password)),
            .button(ButtonCellConfigurator(title: "signup_btn_label".localized, color: .white, background: .black, type: .registerSegue))
        ]
    }

    static var activationCodeData: [AuthElement] {
        return [
            .title("confirm_title_label".localized),
            .textField(TextFieldConfigurator(placeHolder: "confirm_tf_placeHolder".localized, isSecured: false, type: .phoneConfirmNumber)),
            .button(ButtonCellConfigurator(title: "confirm_code_btn_label".localized, color: .white, background: .black, type: .verifyPhoneCode)),

            .textLabel(TextLabelConfigurator(text: "unrecived_code_label".localized, font: UIFont.getLocalizedFont(type: .bold(12)), textColor: #colorLiteral(red: 0.2558659911, green: 0.2558728456, blue: 0.2558691502, alpha: 1), textAlign: .center, type: .phoneCodeResend)),
            .button(ButtonCellConfigurator(title: "resend_code_btn_label".localized, color: .white, background: .black, type: .phoneCodeResend))
        ]
    }

    static var activationCodeDataWait: [AuthElement] {
        return [
            .title("confirm_title_label".localized),
            .textField(TextFieldConfigurator(placeHolder: "confirm_tf_placeHolder".localized, isSecured: false, type: .phoneConfirmNumber)),
            .button(ButtonCellConfigurator(title: "confirm_code_btn_label".localized, color: .white, background: .black, type: .verifyPhoneCode)),

            .textLabel(TextLabelConfigurator(text: "unrecived_code_label".localized, font: UIFont.getLocalizedFont(type: .bold(12)), textColor: #colorLiteral(red: 0.2558659911, green: 0.2558728456, blue: 0.2558691502, alpha: 1), textAlign: .center, type: .phoneCodeResend)),
            .button(ButtonCellConfigurator(title: "resend_code_btn_label".localized, color: .white, background: .black, type: .phoneCodeResendWait))
        ]
    }

    static var forgetPasswordData: [AuthElement] {
        return [
            .textField(TextFieldConfigurator(placeHolder: "forget_tf_placeholder".localized, isSecured: false, type: .email)),
            .button(ButtonCellConfigurator(title: "forget_btn_label".localized, color: .white, background: .black, type: .forgetPassSegue)),
            .textLabel(TextLabelConfigurator(text: "back_to_login".localized, font: UIFont.getLocalizedFont(type: .bold(12)), textColor: #colorLiteral(red: 0.9874494672, green: 0.5041492581, blue: 0.00973271206, alpha: 1), textAlign: NSTextAlignment.right, type: .loginSegue))
        ]
    }

    static var newPasswordData: [AuthElement] {
        return [
            .title("newpass_label_title".localized),
            .textLabel(TextLabelConfigurator(text: "newpass_label_subtitle".localized, font: UIFont.getLocalizedFont(type: .bold(12)), textColor: #colorLiteral(red: 0.9874494672, green: 0.5041492581, blue: 0.00973271206, alpha: 1), textAlign: .center, type: .phoneCodeResend)),
            .textField(TextFieldConfigurator(placeHolder: "forget_tf_placeholder".localized, isSecured: false, type: .email)),
            .textField(TextFieldConfigurator(placeHolder: "pass_tf_placeholder".localized, isSecured: true, type: .password)),
            .textField(TextFieldConfigurator(placeHolder: "repeat_pass_tf_placeholder".localized, isSecured: true, type: .confirmPass)),
            .button(ButtonCellConfigurator(title: "pass_btn_label_confirm".localized, color: .white, background: .black, type: .password))
        ]
    }

}





@IBDesignable
extension UILabel {
    
    @IBInspectable var localizedText: String? {
        get {
            return text
        }
        set {
            text = newValue?.localized
        }
    }
    
    var localizedFont: FontTypesWithSize {
        set {
            font = UIFont.getLocalizedFont(type: newValue)
        }get {
            return .regular(16)
        }
    }
    
}

