//
//  UIButton+App.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
enum ButtonStyles: Int {
    case primary
}

@IBDesignable
extension UIButton {
    @IBInspectable var btnStyle: Int {
        get {
            return 0
        }
        set {
            switch btnStyle {
            case ButtonStyles.primary.rawValue:
                applyStyle(.primary)

            default:
                print("Not implemented yet")
            }
        }
    }

    func applyStyle(_ style: ButtonStyles) {
        switch style {
        case .primary:
            backgroundColor = UIColor.appPumpkinOrange
            cornerRadiusV = 10
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont(name: AppFonts.regularFont, size: 13)
        }
    }
}
