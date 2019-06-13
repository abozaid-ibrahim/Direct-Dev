//
//  UITextField+Localized.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

extension UITextField {
    var localizedFont: FontTypesWithSize {
        set {
            font = UIFont.getLocalizedFont(type: newValue)
        } get {
            return .regular(16)
        }
    }

    @IBInspectable var letterSpacing: CGFloat {
        get {
            // unsupported
            return 0
        }
        set {
            let attrString = NSMutableAttributedString(string: text!)
            attrString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attrString.length))
            attributedText = attrString
        }
    }

    public func attributedPlaceholder(title: String) {
        let attributesStr = NSMutableAttributedString(string: title)
        attributesStr.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "GothamPro-Light", size: 16)!, range: NSRange(location: 0, length: attributesStr.length))
        attributesStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: attributesStr.length))

        attributedPlaceholder = attributesStr
    }

    public func attributedText(title: String) {
        let attributesStr = NSMutableAttributedString(string: title)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22
        paragraphStyle.alignment = NSTextAlignment.left

        attributesStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributesStr.length))
        attributesStr.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "GothamPro", size: 16)!, range: NSRange(location: 0, length: attributesStr.length))
        attributesStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: attributesStr.length))

        attributedPlaceholder = attributesStr
    }
}
