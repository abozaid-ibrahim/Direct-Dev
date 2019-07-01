//
//  UILabel+APP.swift
//  Direct
//
//  Created by abuzeid on 7/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

enum UILabelStyles: Int {
    case normalRegularText = 1
    case normalBoldText = 2
}

@IBDesignable
extension UILabel {
    private struct AssociatedKey {
        static var labelstyle = "UILabel.style.me"
    }

    @IBInspectable var lblStyle: Int {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKey.labelstyle) as? Int {
                print(value)
                setStyle(for: value)
                return value
            } else {
                return 0
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.labelstyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setStyle(for: newValue)
        }
    }

    private func setStyle(for id: Int) {
        switch id {
        case UILabelStyles.normalRegularText.rawValue:
            applyStyle(.normalRegularText)
        case UILabelStyles.normalBoldText.rawValue:
            applyStyle(.normalBoldText)
        default:
            print("Not implemented yet")
        }
    }

    func applyStyle(_ style: UILabelStyles) {
        switch style {
        case .normalRegularText:
            textColor = UIColor.appBlack
            font = UIFont.appRegularFontWith(size: 15)
            minimumScaleFactor = 0.75
        case .normalBoldText:
            textColor = UIColor.appBlack
            font = UIFont.appBoldFontWith(size: 15)
            minimumScaleFactor = 0.75
        }
    }
}
