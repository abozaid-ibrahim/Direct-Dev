//
//  UIButton+App.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
enum ButtonStyles: Int {
    case primary = 1
    case secondary = 2
}

@IBDesignable
extension UIButton {
    private struct AssociatedKey {
        static var buttonStyle = "UIButton.style"
    }

    @IBInspectable var btnStyle: Int {
        get {
            if let rounded = objc_getAssociatedObject(self, &AssociatedKey.buttonStyle) as? Int {
                return rounded
            } else {
                return 0
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.buttonStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            switch btnStyle {
            case ButtonStyles.primary.rawValue:
                applyStyle(.primary)
            case ButtonStyles.secondary.rawValue:
                applyStyle(.secondary)
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
        case .secondary:
            backgroundColor = UIColor.white
            cornerRadiusV = 10
            layer.borderColor = UIColor.appPumpkinOrange.cgColor
            layer.borderWidth = 1
            setTitleColor(.appPumpkinOrange, for: .normal)
            titleLabel?.font = UIFont(name: AppFonts.boldFont, size: 14)
        }
    }
}
